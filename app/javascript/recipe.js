const rec = () => {
    // カテゴリ一覧API
    const all_url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=1092732536630240284';

    const updateText = (data) => {
        for (let i = 0; i < data.length; i++) {
            const insertHtml = `
            <li>
                <a href="${data[i].recipeUrl}" target="_blank">
                <img src="${data[i].foodImageUrl}" alt="${data[i].recipeTitle} 画像">
                </a>
                <h2>${data[i].recipeTitle}</h2>
                <p>${data[i].recipeDescription}</p>
            </li>
        `;
        $('#recipe_list').append(insertHtml);
        }
    }

    // API取得
    $.getJSON(all_url, (data) => {
        const recipes = data.result;
        let recipe_arr = []
        let recipe_obj = {}
        let recipe_dict = []

    // 1) カテゴリ一覧APIのレスポンスをオブジェクトに格納
        $.each(recipes['large'], function(index, value){
            recipe_obj = {
                categoryIdLarge:    value.categoryId,
                categoryIdMedium:   '',
                categoryIdSmall:    '',
                categoryId:         value.categoryId,
                categoryName:       value.categoryName
            }
            recipe_arr.push(recipe_obj)
        })

        $.each(recipes['medium'], function(index, value){
            recipe_obj = {
                categoryIdLarge:    value.parentCategoryId,
                categoryIdMedium:   value.categoryId,
                categoryIdSmall:    '',
                categoryId:         value.parentCategoryId + "-" + value.categoryId,
                categoryName:       value.categoryName,
            }
            recipe_dict[value.categoryId] = value.parentCategoryId
            recipe_arr.push(recipe_obj)
        })

        $.each(recipes['small'], function(index, value){
            recipe_obj = {
                categoryIdLarge:    recipe_dict[value.parentCategoryId],
                categoryIdMedium:   value.parentCategoryId,
                categoryIdSmall:    value.categoryId,
                categoryId:         recipe_dict[value.parentCategoryId] + "-" + value.parentCategoryId + "-" + value.categoryId,
                categoryName:       value.categoryName,
            }
            recipe_arr.push(recipe_obj)
        })

        const food_title = document.getElementById("food_title").value
        let food_id = []
        let category_name = 0

        // 3) 取得した食材と、1)の配列の食材を比較し、合致したカテゴリIDを取得
        $.each(recipe_arr, function(index, value){
            category_name = value.categoryName
            if( category_name.includes(food_title)) {
                food_id.push(value.categoryId)
            }
        })

        // 4) ランキング一覧APIのURLに該当するIdをドッキング
        // $.each(food_id, function(index, value){
        rank_url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1092732536630240284' + '&categoryId=' + food_id[0]
        $.getJSON(rank_url, (data) => {
            const recipes = data.result;
            updateText(recipes)
        })
        // })

        // 5) ランキング一覧APIのURLに該当するIdをドッキング

    });
}

// FIXME : boxの詳細が開かれたときだけ、作用するようにしたい
window.addEventListener('load',rec)