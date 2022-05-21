// FIXME : 食材をクリックしたら、レシピ表示
const rec = () => {
    // カテゴリ一覧API
    const all_url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=1092732536630240284';
    const def_rank_url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1092732536630240284'

    // やりたいこと : レシピを4つ表示
    // ❶ defaultでその日のレシピランキングを表示しておく
    const createText = (data) => {
        for (let i = 0; i < data.length; i++) {
            const createHtml = `
            <li class="recipe-li-${i}">
                <p id="recipe-title"><big>${data[i].recipeTitle}</big></p>
                <a href="${data[i].recipeUrl}" target="_blank">
                <img src="${data[i].foodImageUrl}" alt="${data[i].recipeTitle} 画像" id="recipe-img">
                </a>
                <p id="recipe-description">${data[i].recipeDescription}</p>
            </li>
            `;
            $('#recipe_list').append(createHtml);
        }
    }

    // ❷ タブがクリックされると、表示を上書きする。
    const updateText = (data) => {
        for (let i = 0; i < data.length; i++) {
            const insertHtml = `
                <p id="recipe-h1">${data[i].recipeTitle}</p>
                <a href="${data[i].recipeUrl}" target="_blank">
                <img src="${data[i].foodImageUrl}" alt="${data[i].recipeTitle} 画像" id="recipe-img">
                </a>
                <p id="recipe-p">${data[i].recipeDescription}</p>
            `;
            switch(i) {
                case 0:
                    $('.recipe-li-0').html(insertHtml);
                    break
                case 1:
                    $('.recipe-li-1').html(insertHtml);
                    break
                case 2:
                    $('.recipe-li-2').html(insertHtml);
                    break
                case 3:
                    $('.recipe-li-3').html(insertHtml);
                    break
            }
        }
    }

    // ❶ defaultの表示(本日のランキング)用のJSON取得
    $.getJSON(def_rank_url, (data) => {
        const def_recipes = data.result;
        createText(def_recipes)
    })

    // ❷ タブ毎の表示用のJSON取得
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

    //  食材の値が格納された要素から、食材名を取得
    //  tabがクリックされたら発火させる。
    //  まずは"魚"
        $("#tab-fish-show.tab").on("click",function(){
            let food_title = document.getElementById("food_title_fish").value
            let food_id = []
            let category_name = 0

            // 取得した食材と、1)の配列の食材を比較し、合致したカテゴリIDを取得
            $.each(recipe_arr, function(index, value){
                category_name = value.categoryName
                if( category_name.includes(food_title)) {
                    food_id.push(value.categoryId)
                }
            })

            // 4) ランキング一覧APIのURLに該当するIdをドッキング
            rank_url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1092732536630240284' + '&categoryId=' + food_id[0]
            $.getJSON(rank_url, (data) => {
                const recipes = data.result;
                updateText(recipes)
            })
        })

    //  "野菜"
        $("#tab-veg-show.tab").on("click",function(){
            let food_title = document.getElementById("food_title_veg").value

            let food_id = []
            let category_name = 0

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
        })
    //  "肉"
        $("#tab-meat-show.tab").on("click",function(){
            let food_title = document.getElementById("food_title_meat").value

            let food_id = []
            let category_name = 0

            $.each(recipe_arr, function(index, value){
                category_name = value.categoryName
                if( category_name.includes(food_title)) {
                    food_id.push(value.categoryId)
                }
            })

            rank_url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1092732536630240284' + '&categoryId=' + food_id[0]
            $.getJSON(rank_url, (data) => {
                const recipes = data.result;
                updateText(recipes)
            })
        })

    //  "飲料"
        $("#tab-drink-show.tab").on("click",function(){
            let food_title = document.getElementById("food_title_drink").value

            let food_id = []
            let category_name = 0

            $.each(recipe_arr, function(index, value){
                category_name = value.categoryName
                if( category_name.includes(food_title)) {
                    food_id.push(value.categoryId)
                }
            })

            rank_url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1092732536630240284' + '&categoryId=' + food_id[0]
            $.getJSON(rank_url, (data) => {
                const recipes = data.result;
                updateText(recipes)
            })
        })

        //  "アイス"
        $("#tab-flozen-show.tab").on("click",function(){
            let food_title = document.getElementById("food_title_flozen").value

            let food_id = []
            let category_name = 0

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
        })

        // 食材一覧の「任意の食材」がクリックされたとき、発火
        $("#tab-fish-show.tab").on("click",function(){
            let food_title = document.getElementById("food_title_fish").value
            let food_id = []
            let category_name = 0

            // 取得した食材と、1)の配列の食材を比較し、合致したカテゴリIDを取得
            $.each(recipe_arr, function(index, value){
                category_name = value.categoryName
                if( category_name.includes(food_title)) {
                    food_id.push(value.categoryId)
                }
            })

            // 4) ランキング一覧APIのURLに該当するIdをドッキング
            rank_url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1092732536630240284' + '&categoryId=' + food_id[0]
            $.getJSON(rank_url, (data) => {
                const recipes = data.result;
                updateText(recipes)
            })
        })

    });
}

// TODO : boxの詳細が開かれたときだけ、作用するようにしたい
window.addEventListener('DOMContentLoaded',rec)