# frozen_string_literal:true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'when user is logged in' do
    before(:each) do
      user
    end
    describe 'Get /new' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      it 'initializes new post' do
        get :new, params: { user_id: user_one.id }
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('new')
      end
    end

    describe 'POST /create' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      let(:post_one) { build(:post, user_id: user_one.id) }
      before do
        allow_any_instance_of(controller.class).to receive(:current_user).and_return(user_one)
      end

      context 'when user is logged in and tries to create post' do
        it 'should create post when the attributes are valid' do
          post :create, params: { user_id: user_one.id, caption: post_one.caption, images: post_one.images }
          expect(flash[:success]).to have_content 'Post was successfully created.'
          expect(response).to redirect_to user_one
        end
      end

      context 'when user is logged in and tries to create post with nil caption' do
        it 'should not be able to create post with invalid attributes' do
          post :create, params: { user_id: user_one.id, caption: nil, images: post_one.images }
          expect(flash[:alert]).to have_content 'Post was not created.'
          expect(response).to redirect_to user_one
        end
      end
    end

    describe 'DELETE /destroy' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      let(:post_one) { create(:post, user: user_one) }

      before do
        allow_any_instance_of(controller.class).to receive(:current_user).and_return(user_one)
      end

      context 'when user tries to delete post'
      it 'should be able to delete the post' do
        delete :destroy, params: { id: post_one.id }
        expect(flash[:success]).to have_content 'Post was successfully destroyed.'

        expect(response).to redirect_to user_one
      end

      context 'when user tries to delete post but for some reason' do
        before do
          allow(Post).to receive(:find).and_return(post_one)
          allow(post_one).to receive(:destroy).and_return(false)
        end
        it 'is not able to delete' do
          delete :destroy, params: { id: post_one.id }
          expect(response).to redirect_to user_one
          expect(flash[:alert]).to have_content 'Post was not destroyed.'
        end
      end
    end

    describe 'PUT /update' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      let(:post_one) { create(:post, user_id: user_one.id) }
      before do
        allow_any_instance_of(controller.class).to receive(:current_user).and_return(user_one)
      end

      context 'when user is logged in and tries to create post' do
        it 'user should create post when the attributes are valid' do
          post :update, params: { id: post_one.id, post: { 'caption': 'xyzasd' } }
          expect(response).to redirect_to post_path(assigns(:post).id)
          expect(flash[:success]).to have_content 'Post was successfully updated.'
        end
      end
    end
  end

  describe 'when user is not logged in' do
    describe 'Get /new' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      it 'should not authenticate it' do
        get :new, params: { user_id: user_one.id }
        expect(flash[:alert]).to have_content 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'POST /create' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      let(:post_one) { build(:post, user_id: user_one.id) }
      before do
        allow_any_instance_of(controller.class).to receive(:current_user).and_return(user_one)
      end

      context 'when user is not logged in and tries to create post' do
        it 'should not authenticate it' do
          post :create, params: { user_id: user_one.id, caption: post_one.caption, images: post_one.images }
          expect(flash[:alert]).to have_content 'You need to sign in or sign up before continuing.'
        end
      end
    end

    describe 'DELETE /destroy' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      let(:post_one) { create(:post, user: user_one) }

      before do
        allow_any_instance_of(controller.class).to receive(:current_user).and_return(user_one)
      end

      context 'when user tries to delete post'
      it 'should not authenticate it' do
        delete :destroy, params: { id: post_one.id }
        expect(flash[:alert ]).to have_content 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'PUT /update' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      let(:post_one) { create(:post, user_id: user_one.id) }
      before do
        allow_any_instance_of(controller.class).to receive(:current_user).and_return(user_one)
      end

      context 'when user is not logged in and tries to create post' do
        it 'should not authenticate it' do
          post :update, params: { id: post_one.id, post: { 'caption': 'xyzasd' } }
          expect(flash[:alert]).to have_content 'You need to sign in or sign up before continuing.'
        end
      end
    end
  end
end
