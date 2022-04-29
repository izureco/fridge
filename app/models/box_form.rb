# BoxとTagのFormオブジェクト
class BoxForm
  include ActiveModel::Model

  # 属性定義
  attr_accessor(
    # boxesテーブルの属性値
      :box_title, :description, :image, :user_id,
    # boxtagsテーブルの属性値
      :tag_name
  )

  # validation定義
  with_options presence: true do
    validates :box_title
    validates :description
    validates :image
    validates :user_id
  end

  # saveメソッド定義
  def save(tag_list)
    box = Box.create(box_title: box_title, description: description, image: image, user_id: user_id)
    i = 0

    if tag_list != nil
      box_boxtag_records = BoxBoxtagRelation.where(box_id: box.id)
      box_boxtag_records.destroy_all
    end

    tag_list.each do |t|
      relative_tag = Boxtag.where(tag_name: tag_list[i]).first_or_initialize
      relative_tag.save
      BoxBoxtagRelation.create(box_id: box.id, boxtag_id: relative_tag.id)
      i += 1
    end
  end
end
