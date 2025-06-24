module ApplicationHelper

 def display_image_or_default(image, width: 100, height: 100, classes: "")
  if image.attached?
    image_tag image, width: width, height: height, class: classes
  else
    image_tag "noimage.png", width: width, height: height, class: classes
  end
 end 
end
