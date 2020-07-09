require 'rails_helper'

describe Api::V1::ApplicantsController do
  let(:student) { create(:user, role: :student) }
  let(:test_1) { create(:test, :with_many_questions) }
  let(:test_2) { create(:test, :with_many_questions) }

  describe "POST #create" do
    let(:action) {post :create, params: {}, body: { applicant: applicant_attributes }.to_json, as: :json}

    context 'valid request' do
      let(:applicant_attributes) { { test_id: test_1.id,
                                     result: [
                                       {
                                         "question_id": test_1.questions.first.id,
                                         "answer_ids": [test_1.questions.first.answer_ids.sample]
                                       },
                                       {
                                         "question_id": test_1.questions.last.id,
                                         "answer_ids": [test_1.questions.last.answer_ids.sample]
                                       }
                                     ] } }
      before :each do
        set_authentication_headers_for(student)
      end

      it 'returns status 200' do
        action
        expect(response).to have_http_status 200
      end

      it 'Submitted test successfully' do
        action
        body = JSON.parse(response.body)
        expect(body['success']).to eq true
        expect(body['message']).to eq 'Saved successfully'
      end
    end

    context 'invalid request' do
      let(:applicant_attributes) { { test_id: test_1.id,
                                     result: [
                                       {
                                         "question_id": test_1.questions.first.id,
                                         "answer_ids": [test_1.questions.first.answer_ids.sample]
                                       },
                                       {
                                         "question_id": test_2.questions.last.id,
                                         "answer_ids": [test_2.questions.last.answer_ids.sample]
                                       }
                                     ] } }

      before :each do
        set_authentication_headers_for(student)
      end

      it 'question or answer not belong to test' do
        action
        body = JSON.parse(response.body)
        expect(response).to have_http_status 422
        expect(body['message']).to eq 'Unprocessable Entity'
        expect(body['errors']['applicant']).to include 'Applicant has questions not belong to this test'
        expect(body['errors']['applicant']).to include 'Applicant has answers not belong to this test'
      end
    end

    context 'invalid auth request' do
      let(:applicant_attributes) { { test_id: test_1.id,
                                     result: [
                                       {
                                         "question_id": test_1.questions.first.id,
                                         "answer_ids": [test_1.questions.first.answer_ids.sample]
                                       },
                                       {
                                         "question_id": test_1.questions.last.id,
                                         "answer_ids": [test_1.questions.last.answer_ids.sample]
                                       }
                                     ] } }

      it 'returns status 401' do
        action
        body = JSON.parse(response.body)

        expect(response).to have_http_status 401
        expect(body['errors']).to include 'You need to sign in or sign up before continuing.'
      end

      it 'user without student role' do
        teacher = create(:user, role: :teacher)
        set_authentication_headers_for(teacher)

        action
        body = JSON.parse(response.body)

        expect(response).to have_http_status 401
        expect(body['success']).to eq false
        expect(body['errors']['unauthorized']).to include 'You are not allow to do this action'
      end
    end
  end
end