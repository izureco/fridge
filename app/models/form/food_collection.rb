class Form::FoodCollection < Form::Base
  FORM_COUNT = 3
    #ここで、作成したい登録フォームの数を指定
  attr_accessor(
    :foods,
    :availability, :food_title, :number_title, :purchase_date, :expiry_date, :price, :give_id, :category_id,
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

  def initialize(attributes = {})
    super attributes
    self.foods = FORM_COUNT.times.map { Food.new() } unless self.foods.present?
  end

  # def initialize(box_id, attributes = )
  #   if attributes.present?
  #     self.foods = attributes.map do |value|
  #       Food.new(
  #         food_title: value["food_title"],
  #         number_title: value["number_title"],
  #         purchase_date: value["purchase_date"],
  #         expiry_date: value["expiry_date"],
  #         price: value["price"],
  #         give_id: value["give_id"],
  #         box_id: value["box_id"]
  #       )
  #     end
  #   else
  #     self.foods = FORM_COUNT.times.map { Food.new }
  #   end
  # end

  # def persisted?
  #   false
  # end

  def foods_attributes=(attributes)
    self.foods = attributes.map { |_, v| Food.new(v) }
  end

  def save
    errors = []
    is_success = true
    ava_count = 0
    Food.transaction do
      self.foods.each do |food|
        food.valid?
        errors << food.errors.full_messages
        if food.availability
          f = Food.new(box_id: box_id)
          food.box_id = f.box_id
          # category_idを付与できるまで、一時的な処置
          food.category_id = 1
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
    # errors = []
    # # Foodクラスの中でどれか1つでも例外が発生すると、ロールバックしてくれる。登録するかしないかのどちらか。
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
end