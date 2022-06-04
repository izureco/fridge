class Form::FoodCollection < Form::Base
  FORM_COUNT = 5
    #ここで、作成したい登録フォームの数を指定
  attr_accessor(
    :foods,
    :id, :availability, :food_title, :number_title, :purchase_date, :expiry_date, :price, :give_id, :category_id,
    :box_id
  )
    # foodsに作成したモデルが格納される

  with_options presence: true do
    validates :food_title
    validates :number_title
    validates :purchase_date
    validates :expiry_date
    validates :price
  end

  # 初期化メソッド
  # 引数として, attributesはハッシュが格納される。
  # もし引数が無いとき(.newだけ)は、attributesに空のハッシュが格納される。
  # def initialize(attributes = {})
  #   # super : 親クラスのassign_attributesメソッドを呼び出す
  #   # assing_attributes : 特定のattributesを変更するメソッド。DBへの保存は行わない。保存するなら、saveかupdate!
  #   super attributes
  #   # <new/createアクションのとき>
  #   ## もしfoodsが空なら、フォームとして5つのインスタンスを作成する。

  #   # <edit/updateアクションのとき>
  #   ## foodsが存在するなら、フォームにFood.new(attributes)すれば入るかな?
  #   self.foods = FORM_COUNT.times.map { Food.new() } unless self.foods.present?
  # end

  def initialize(attributes = {})
    # editのとき
    if attributes.present?
      # self.foods = attributes.map do |value|
      # editアクションが選択されたとき、1つのレコードを保存することはできた
      # TODO:category IDに応じて、登録済食材を表示させる
      # 実装手順
      # 1) FORM_COUNT×タブの分だけ、空のフォームを生成する
      # 2) 1)を一つずつ参照し、@formを代入していく。
      # 
      # 3) そのとき、category_idによって、インスタンスの作成箇所を変える。
      i = 0
      count = 1
      self.foods = FORM_COUNT.times.map { Food.new }
      case count
        # fields_for1回目(タブがfish)
        when 1 then
          FORM_COUNT.times do
            if attributes[:foods][i].present? && attributes[:foods][i]["category_id"] == 1
              self.foods[i] =
                Food.new(
                  # availability: value["availability"],
                  food_title: attributes[:foods][i]["food_title"],
                  number_title: attributes[:foods][i]["number_title"],
                  purchase_date: attributes[:foods][i]["purchase_date"],
                  expiry_date: attributes[:foods][i]["expiry_date"],
                  price: attributes[:foods][i]["price"],
                  category_id: attributes[:foods][i]["category_id"],
                  give_id: attributes[:foods][i]["give_id"],
                  box_id: attributes[:foods][i]["box_id"]
                )
            end
            i += 1
          end
        # fields_for2回目(タブがVegitable)
        when 2 then
          FORM_COUNT.times do
            if attributes[:foods][i].present? && attributes[:foods][i]["category_id"] == 2
              self.foods[i] =
                Food.new(
                  # availability: value["availability"],
                  food_title: attributes[:foods][i]["food_title"],
                  number_title: attributes[:foods][i]["number_title"],
                  purchase_date: attributes[:foods][i]["purchase_date"],
                  expiry_date: attributes[:foods][i]["expiry_date"],
                  price: attributes[:foods][i]["price"],
                  category_id: attributes[:foods][i]["category_id"],
                  give_id: attributes[:foods][i]["give_id"],
                  box_id: attributes[:foods][i]["box_id"]
                )
            end
            i += 1
          end
      end
      count += 1
    # newアクションのとき
    else
      self.foods = FORM_COUNT.times.map { Food.new }
    end
  end

  # fields_forを使用するために必要
  # fields_forの第一引数として用いる
  def foods_attributes=(attributes)
    # map : attributesの配列1つ1つに対応するFoodのインスタンスを生成してくれる
    # hashにmapを適応させるときは、map{|key, hash| 実行する処理}という書き方をする。
    # {|_, v|}の意味 : attributesはハッシュ形式なので、本来であれば▲と書くけど、key部分は使用しないので、_という変数にしている。
    self.foods = attributes.map { |_, v| Food.new(v) }
  end

  def save
    is_success = true
    ava_count = 0
    Food.transaction do
      self.foods.each do |food|
        food.valid?
        if food.availability
          f = Food.new(box_id: box_id)
          food.box_id = f.box_id
          is_success = false unless food.save
          ava_count += 1
        end
      end
      if ava_count == 0
        is_success = false
      end
      raise ActiveRecord::RecordInvalid unless is_success
    end

    rescue
      p 'error'
    ensure
      return is_success
  end

  # TODO : 登録済食材の個数によらず、フォームを常に5つ表示させる(category_idに連動させて)
  # TODO : 食材の削除ができる
  # TODO : validationのチェック
  def update(box)
    is_success = true
    i = 0
    Food.transaction do
      box.foods.each do |food|
        food.valid?
        f = Food.new(box_id: box.id)
        food.box_id = f.box_id
        binding.pry
        is_success = false unless food.update(
          food_title: foods[i]["food_title"],
          number_title: foods[i]["number_title"],
          purchase_date: foods[i]["purchase_date"],
          expiry_date: foods[i]["expiry_date"],
          price: foods[i]["price"],
          give_id: foods[i]["give_id"]
        )
        i += 1
      end
    raise ActiveRecord::RecordInvalid unless is_success
    end

    rescue
      p 'error'
    ensure
      return is_success
  end

end

    # errors = []
    ## Foodクラスの中でどれか1つでも例外が発生すると、ロールバックしてくれる。登録するかしないかのどちらか。
    # Food.transaction do
    #   # フォーム入力されたオブジェクトのfoods(3つの食材が配列として格納されている)を1つずつDBに保存する
    #   self.foods.map do |food|
    #     # なぜかbox_idがmergeされないので、個別にインスタンスを作って、box_idを取得
    #     f = Food.new(box_id: box_id)
    #     # box_idを個別の食材レコードに保存
    #     food.box_id = f.box_id
    #     food.save!
    #     # DBに保存する。save!とすると、処理が失敗したとき例外を吐いてくれるメソッド
    #     # つまり、validationに抵触し保存に失敗すると、transactionから抜け出す。
    #     # if !food.save
    #     #   errors << food.errors.full_messages
    #     # end
    #   end
    #   # raiseで例外を発生させられる。今回は、Rollback
    #     return true
    #   rescue => each
    #     return false
    #   # raise ActiveRecord::Rollback if errors.present?
    # end
    # # saveの結果
    # # errorsに値があればエラー文を戻し、無ければnilを戻す
    # # if errors.present?
    # #   return false, errors
    # # else
    # #   return true
    # # end
    # #   return true
    # # rescue => e
    # #   return false