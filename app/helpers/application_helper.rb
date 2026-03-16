module ApplicationHelper

  def display_image_or_default(image, width: 150, height: 150, classes: "")
    if image.respond_to?(:variant) && image.attached?
      # 生成サイズを2倍にする（Retina対応）
      # saver: { quality: 85 } を足すことで、容量を抑えつつ鮮明さを維持
      processed_image = image.variant(
        resize_to_fill: [width * 2, height * 2], 
        saver: { quality: 85 }
      )
      
      # 表示サイズ（HTML上のwidth/height）は元の値のままにする
      image_tag processed_image, width: width, height: height, class: classes, loading: "lazy"
    else
      image_tag "noimage.png", width: width, height: height, class: classes
    end
  end

  def unchecked_notifications_count
    return 0 unless user_signed_in?
    current_user.passive_notifications.unchecked.count
  end
end  