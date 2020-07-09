require 'rails_helper'

describe Api::V1::TestsController do
  let(:student) { create(:user, role: :student) }

  describe "GET #index" do
    context 'valid request' do
      before :each do
        set_authentication_headers_for(student)
        create_list(:test, 5, :with_many_questions)
      end

      it 'returns status 200' do
        get :index
        expect(response).to have_http_status 200
      end

      it 'return all tests' do
        get :index
        body = JSON.parse(response.body)
        expect(body['data'].count).to eq 5
      end

      it 'return 10 test per page' do
        create_list(:test, 10, :with_many_questions)

        get :index
        body = JSON.parse(response.body)
        expect(body['per_page']).to eq 10
        expect(body['data'].count).to eq 10
      end

      it 'return 5 tests on page 2' do
        create_list(:test, 10, :with_many_questions)

        get :index, params: { page: 2 }
        body = JSON.parse(response.body)
        expect(body['current_page']).to eq 2
        expect(body['data'].count).to eq 5
      end
    end

    context 'invalid auth request' do
      before :each do
        create_list(:test, 5, :with_many_questions)
      end

      it 'returns status 401' do
        get :index
        body = JSON.parse(response.body)

        expect(response).to have_http_status 401
        expect(body['errors']).to include 'You need to sign in or sign up before continuing.'
      end

      it 'user without student role' do
        teacher = create(:user, role: :teacher)
        set_authentication_headers_for(teacher)

        get :index
        body = JSON.parse(response.body)

        expect(response).to have_http_status 403
        expect(body['success']).to eq false
        expect(body['errors']['unauthorized']).to include 'You are not allow to do this action'
      end
    end
  end

  describe "GET #show" do
    before :each do
      @test = create(:test, :with_many_questions)
    end

    context 'valid request' do
      before :each do
        set_authentication_headers_for(student)
      end

      it 'returns status 200' do
        get :show, params: { id: @test.id }
        expect(response).to have_http_status 200
      end

      it 'return test detail' do
        get :show, params: { id: @test.id }
        body = JSON.parse(response.body)
        expect(body['success']).to eq true
        expect(body['data']['id']).to eq @test.id
        expect(body['data']['questions'].count).to be > 1
        expect(body['data']['questions'].first['answers'].count).to be > 1
      end
    end

    context 'invalid request' do
      before :each do
        set_authentication_headers_for(student)
      end

      it 'returns status 404' do
        get :show, params: { id: 9999 }
        body = JSON.parse(response.body)

        expect(response).to have_http_status 404
        expect(body['errors']['record_not_found']).to include 'Record Not Found'
      end
    end

    context 'invalid auth request' do
      it 'returns status 401' do
        get :show, params: { id: @test.id }
        body = JSON.parse(response.body)

        expect(response).to have_http_status 401
        expect(body['errors']).to include 'You need to sign in or sign up before continuing.'
      end

      it 'user without student role' do
        teacher = create(:user, role: :teacher)
        set_authentication_headers_for(teacher)

        get :show, params: { id: @test.id }
        body = JSON.parse(response.body)

        expect(response).to have_http_status 403
        expect(body['success']).to eq false
        expect(body['errors']['unauthorized']).to include 'You are not allow to do this action'
      end
    end
  end
end