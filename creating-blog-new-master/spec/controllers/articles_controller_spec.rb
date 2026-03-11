require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'before_action' do
    it { is_expected.to use_before_action(:set_article) }
  end

  describe 'GET #index' do
    let!(:articles) { create_list(:article, 30) }

    context '1ページ目の場合' do
      before do
        get :index, params: { page: 1 }
      end

      it 'result' do
        # response
        is_expected.to respond_with(:success)
        is_expected.to render_with_layout(:application)
        is_expected.to render_template(:index)

        # assigns
        expect(assigns[:articles].count).to eq 25
        expect(assigns[:articles]).to eq Article.order(id: :desc).page(1).per(25)
      end
    end

    context '2ページ目の場合' do
      before do
        get :index, params: { page: 2 }
      end

      it 'result' do
        # response
        is_expected.to respond_with(:success)

        # assigns
        expect(assigns[:articles].count).to eq 5
        expect(assigns[:articles]).to eq Article.order(id: :desc).page(2).per(25)
      end
    end
  end

  describe 'GET #show' do
    let(:article) { create(:article) }
    before do
      get :show, params: { id: article.id }
    end

    it 'result' do
      is_expected.to respond_with(:success)
      is_expected.to render_with_layout(:application)
      is_expected.to render_template(:show)
    end
  end

  describe 'GET #new' do
    context 'ログイン済み' do
      login_user
      before do
        get :new
      end

      it 'result' do
        is_expected.to respond_with(:success)
        is_expected.to render_with_layout(:application)
        is_expected.to render_template(:new)
      end
    end
  end

  describe 'POST #create' do
    context 'ログイン済み' do
      login_user
      context '入力エラー無し' do
        before do
          article_params = attributes_for(:article)
          post :create, params: { article: article_params }
        end

        it 'result' do
          # response
          is_expected.to respond_with(:redirect)
          is_expected.to redirect_to(articles_path)

          # assigns
          expect(assigns[:article].persisted?).to be_truthy

          # flash
          is_expected.to set_flash[:notice]
            .to(I18n.t('label.create_success', model: Article.model_name.human))
        end
      end

      context '入力エラー有り' do
        before do
          article_params = attributes_for(:article, title: nil)
          post :create, params: { article: article_params }
        end

        it 'result' do
          # response
          is_expected.to respond_with(:success)
          is_expected.to render_with_layout(:application)
          is_expected.to render_template(:new)

          # assigns
          expect(assigns[:article].persisted?).to be_falsy

          # flash
          is_expected.to_not set_flash[:notice]
        end
      end

      context '画像あり' do
        before do
          article_params = attributes_for(:article).merge(image: fixture_file_upload('../fixtures/files/test_image_50.jpg', 'image/jpeg'))
          post :create, params: { article: article_params }
        end

        it 'result' do
          # response
          is_expected.to respond_with(:redirect)
          is_expected.to redirect_to(articles_path)

          # assigns
          expect(assigns[:article].persisted?).to be_truthy
          expect(assigns[:article].image?).to be_truthy

          # flash
          is_expected.to set_flash[:notice]
            .to(I18n.t('label.create_success', model: Article.model_name.human))
        end
      end

      context '画像あり（51KB以上）' do
        before do
          article_params = attributes_for(:article).merge(image: fixture_file_upload('../fixtures/files/test_image_51.jpg', 'image/jpeg'))
          post :create, params: { article: article_params }
        end

        it 'result' do
          # response
          is_expected.to respond_with(:success)
          is_expected.to render_with_layout(:application)
          is_expected.to render_template(:new)

          # assigns
          expect(assigns[:article].persisted?).to be_falsy

          # flash
          is_expected.to_not set_flash[:notice]
        end
      end
    end
  end

  describe 'GET #edit' do
    let(:article) { create(:article) }
    context 'ログイン済み' do
      login_user
      before do
        get :edit, params: { id: article.id }
      end

      it 'result' do
        is_expected.to respond_with(:success)
        is_expected.to render_with_layout(:application)
        is_expected.to render_template(:edit)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:article) { create(:article, title: '元のタイトル', text: '元の本文') }

    context 'ログイン済み' do
      login_user

      context '入力エラー無し' do
        let(:article_params) { { title: '新しいタイトル', text: '新しい本文' } }
        before do
          patch :update, params: { id: article.id, article: article_params }
        end

        it 'result' do
          # response
          is_expected.to respond_with(:redirect)
          is_expected.to redirect_to(articles_path)

          # assigns
          expect(article.reload.title).to eq '新しいタイトル'
          expect(article.reload.text).to eq '新しい本文'

          # flash
          is_expected.to set_flash[:notice]
            .to(I18n.t('label.update_success', model: Article.model_name.human))
        end
      end

      context '入力エラー有り' do
        let(:article_params) { { title: nil } }
        before do
          patch :update, params: { id: article.id, article: article_params }
        end

        it 'result' do
          # response
          is_expected.to respond_with(:success)
          is_expected.to render_with_layout(:application)
          is_expected.to render_template(:edit)

          # assigns
          expect(article.reload.title).to eq '元のタイトル'
          expect(article.reload.text).to eq '元の本文'

          # flash
          is_expected.to set_flash[:error]
        end
      end

      context '画像あり' do
        let(:image) { fixture_file_upload('../fixtures/files/test_image_50.jpg', 'image/jpeg') }
        let(:article_params) { { image: image } }
        before do
          patch :update, params: { id: article.id, article: article_params }
        end

        it 'result' do
          # response
          is_expected.to respond_with(:redirect)
          is_expected.to redirect_to(articles_path)

          # assigns
          expect(article.reload.image.file.filename).to eq 'test_image_50.jpg'

          # flash
          is_expected.to set_flash[:notice]
            .to(I18n.t('label.update_success', model: Article.model_name.human))
        end
      end

      context '画像あり（51KB以上）' do
        let(:image) { fixture_file_upload('../fixtures/files/test_image_51.jpg', 'image/jpeg') }
        let(:article_params) { { image: image } }
        before do
          patch :update, params: { id: article.id, article: article_params }
        end

        it 'result' do
          # response
          is_expected.to respond_with(:success)
          is_expected.to render_with_layout(:application)
          is_expected.to render_template(:edit)

          # assigns
          expect(article.reload.image?).to be_falsy

          # flash
          is_expected.to set_flash[:error]
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:article) { create(:article) }
    context 'ログイン済み' do
      login_user
      before do
        delete :destroy, params: { id: article.id }
      end

      it 'result' do
        # response
        is_expected.to respond_with(:redirect)
        is_expected.to redirect_to(articles_path)

        # assigns
        expect(assigns[:article].destroyed?).to be_truthy

        # flash
        is_expected.to set_flash[:notice]
          .to(I18n.t('label.destroy_success', model: Article.model_name.human))
      end
    end
  end
end
