const tab = () => {
// $(function() {
  let tabs = $(".tab"); // tabのクラスを全て取得し、変数tabsに配列で定義
  let tab_id = 1
  $(".tab").on("click", function() { // tabをクリックしたらイベント発火
    $(".active").removeClass("active"); // activeクラスを消す
    $(this).addClass("active"); // クリックした箇所にactiveクラスを追加
    const index = tabs.index(this); // クリックした箇所がタブの何番目か判定し、定数indexとして定義
    $(".content").removeClass("show").eq(index).addClass("show"); // showクラスを消して、contentクラスのindex番目にshowクラスを追加
  })

  // どのタブが選択されたか判断
  // 1) そのときのfood.titleのvalueを取得
  // 2) 
  // FIXME: デフォルトで何も開かれてない状態にする(現状、魚のタブがクリックされてない=idが付与されてないから)
  $("#tab-fish.tab").on("click", function(){
    tab_id = $("#tab-fish.tab").data("value");
    $(".send-data-fish").val(tab_id)
  });

  $("#tab-veg.tab").on("click", function(){
    tab_id = $("#tab-veg.tab").data("value");
    $(".send-data-veg").val(tab_id)
  });

  $("#tab-meat.tab").on("click", function(){
    tab_id = $("#tab-meat.tab").data("value");
    $(".send-data-meat").val(tab_id)
  });

  $("#tab-drink.tab").on("click", function(){
    tab_id = $("#tab-drink.tab").data("value");
    $(".send-data-drink").val(tab_id)
  });

  $("#tab-flozen.tab").on("click", function(){
    tab_id = $("#tab-flozen.tab").data("value");
    $(".send-data-flozen").val(tab_id)
    debugger;
  });

  // $("#food-btn").on("click", function(){
  //   debugger;
  //   $.post('box_foods_path',{category_id: tab_id})
  // })
}

window.addEventListener('DOMContentLoaded',tab)