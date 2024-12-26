module Public::PostsHelper

  def render_postable_details(postable)
    return content_tag(:div, "関連情報が見つかりませんでした。", class: "alert alert-warning") unless postable

    case postable
    when Place
      render partial: "public/posts/place_details", locals: { place: postable }
    when Event
      render partial: "public/posts/event_details", locals: { event: postable }
    else
      content_tag(:div, "不明な情報タイプです。", class: "alert alert-danger")
    end
  end
end
