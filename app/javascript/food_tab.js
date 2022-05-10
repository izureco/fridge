// FIXME : 1回ロードしないとタブが切り替わらない
$(function() {
  let tabs = $(".tab"); // tabのクラスを全て取得し、変数tabsに配列で定義
  let tab_id = 1
  $(".tab").on("click", function() { // tabをクリックしたらイベント発火
    $(".active").removeClass("active"); // activeクラスを消す
    $(this).addClass("active"); // クリックした箇所にactiveクラスを追加
    const index = tabs.index(this); // クリックした箇所がタブの何番目か判定し、定数indexとして定義
    $(".content").removeClass("show").eq(index).addClass("show"); // showクラスを消して、contentクラスのindex番目にshowクラスを追加
  })

  $("#tab-fish.tab").on("click", function(){
    // どのタブが選択されたか判断
    tab_id = $("#tab-fish.tab").data("value");
    $("#send-data").val(tab_id)
  });

  $("#tab-veg.tab").on("click", function(){
    // タブのIDを取得
    tab_id = $("#tab-veg.tab").data("value");
    $("#send-data").val(tab_id)
    debugger;
  });

  // $("#food-btn").on("click", function(){
  //   debugger;
  //   $.post('box_foods_path',{category_id: tab_id})
  // })

})