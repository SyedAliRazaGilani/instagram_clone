# frozen_string_literal: true

# Posts Helper
module PostsHelper
  def already_liked(id)
    Like.exists?(post_id: id, user_id: current_user.id)
  end

  def get_like_id(id)
    current_user.likes.where(post_id: id).ids[0]
  end

  def test(post_id)
    if already_liked(post_id)
      link_to like_path(get_like_id(post_id), post_id: post_id), method: :delete, remote: true, class: 'like' do
        "<i class='fa fa-heart'></i>".html_safe
      end
    else
      link_to likes_path(post_id: post_id), method: :post, remote: true, class: 'like' do
        "<i class='fa fa-heart-o'></i>".html_safe
      end
    end
  end
end
