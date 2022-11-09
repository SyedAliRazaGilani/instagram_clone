# frozen_string_literal: true

# Users Helper
module UsersHelper
  def follower_helper
    if followed?
      link_to user_follower_path(@user.id, @user.followers.follower_id), method: :delete do
        "<i class='fa fa-user-times'></i>".html_safe
      end
    else
      link_to user_followers_path(@user.id, follower_id: current_user.id), method: :post do
        "<i class='fa fa-user-plus'></i>".html_safe
      end
    end
  end

  def followed?
    @user.followers.any? do |follower|
      follower.follower_id == current_user.id && follower.user_id == @user.id && follower.friend == true
    end
  end

  def post_access
    @user.followers.any? do |follower|
      follower.follower_id == current_user.id && follower.friend == true
    end
  end

  def follow_button(user)
    if user.followers.first.nil? == false
      link_to user_follower_path(user.id, user.follower_ids.first), method: :delete do
        "<i class='fa fa-user-times fa-2x m-4'></i>".html_safe
      end
    else
      link_to user_followers_path(user.id, follower_id: current_user.id), method: :post do
        "<i class='fa fa-user-plus fa-2x m-4'></i>".html_safe
      end
    end
  end

  def avatar(user)
    if user.avatar.attached?
      link_to user_stories_path(user.id) do
        if user.stories.exists?
          image(user.avatar, class_name = '')
          image_tag(user.avatar,  height: 250,  width: 250, style: 'border-radius: 50%; border: 3px solid red;')
        else
          image_tag(user.avatar,  height: 250,  width: 250, style: 'border-radius: 50%; border: 1px solid black;')
        end
      end
    end
  end
end
