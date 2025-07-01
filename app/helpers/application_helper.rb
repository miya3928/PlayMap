module ApplicationHelper

  def display_image_or_default(image, width: 100, height: 100, classes: "")
    if image.respond_to?(:variant) && image.attached?
      image_tag image.variant(resize_to_fill: [width, height]), width: width, height: height, class: classes
    else
      image_tag "noimage.png", width: width, height: height, class: classes
    end
  end
end
