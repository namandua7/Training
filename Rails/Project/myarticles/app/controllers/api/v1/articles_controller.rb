module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                articles = Article.all
                render json: {status: 'Success', message: 'Articles loaded', data:articles}, status: :ok
            end

            def show
                article = Article.find(params[:id])
                render json: {status: 'Success', message: 'Article loaded', data:article}, status: :ok
            end
            def create
                article = Article.new(article_params)

                if article.save
                    render json: {status: 'Success', message: 'Article Saved', data:article}, status: :ok
                else
                    render json: {status: 'Error', message: 'Article not saved', data:article.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: {status: 'Success', message: 'Article destroyed', data:article}, status: :ok
            end
            private

            def article_params
                params.permit(:title, :body)
            end
        end
    end
end