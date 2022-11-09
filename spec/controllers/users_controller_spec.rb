# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'when user is logged in' do
    before(:each) do
      user
    end
    describe 'Get /new' do
      it 'should render index page when user is logged in' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('index')
      end
    end

    describe 'Get /show' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      it 'should show a user profile after getting user id of a user' do
        get :show, params: { id: user_one.id }
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('show')
      end
    end

    describe 'Get /search' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      it 'shows a search result' do
        get :search, params: { search: 'ali' }
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('search')
      end
    end

    describe 'Get /requests' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      it 'should show a search result' do
        get :requests
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('requests')
      end
    end

    describe 'PUT/update' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      before do
        allow_any_instance_of(controller.class).to receive(:current_user).and_return(user_one)
      end
      context 'when the user is logged in and it tries to update user info' do
        it 'should redirect it to user_one path with success notice' do
          put :update,
              params: { id: user_one.id,
                        user: { 'username': 'abcdef', 'name': 'aqeel', 'email': 'xyz@test.com',
                                'mobilenumber': '090078601', 'public': false } }
          expect(response).to redirect_to user_one
          expect(flash[:notice]).to have_content 'updated info'
        end
      end
      context 'when user is logged in and tries to update user info with wrong attributes' do
        it 'should redirect to user_path with failure alert' do
          put :update,
              params: { id: user_one.id,
                        user: { 'username': nil, 'name': 'aqeel', 'email': 'xyz@test.com', 'mobilenumber': '090078601',
                                'public': false } }
          expect(response).to redirect_to user_one
          expect(flash[:alert]).to have_content 'could not update information'
        end
      end
    end
  end

  describe 'when user is not logged-in' do
    describe 'Get /new' do
      it 'should not authenticate it' do
        get :index
        expect(flash[:alert]).to have_content 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'Get /show' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      it 'should not authenticate it' do
        get :show, params: { id: user_one.id }
        expect(flash[:alert]).to have_content 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'Get /search' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      it 'should not authenticate it' do
        get :search, params: { search: 'ali' }
        expect(flash[:alert]).to have_content 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'Get /requests' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      it 'should not authenticate it' do
        get :requests
        expect(flash[:alert]).to have_content 'You need to sign in or sign up before continuing.'
      end
    end
    describe 'PUT/update' do
      let(:user_one) { create(:user, email: 'abc@text.com') }
      before do
        allow_any_instance_of(controller.class).to receive(:current_user).and_return(user_one)
      end
      context 'when user is not logged in and it tries to update info' do
        it 'should not authenticate it' do
          put :update,
              params: { id: user_one.id,
                        user: { 'username': 'abcdef', 'name': 'aqeel', 'email': 'xyz@test.com',
                                'mobilenumber': '090078601', 'public': false } }
          expect(flash[:alert]).to have_content 'You need to sign in or sign up before continuing.'
        end
      end
    end
  end
end
