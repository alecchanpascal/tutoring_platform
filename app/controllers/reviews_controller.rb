class ReviewsController < ApplicationController
    before_action :find_user
    before_action :find_review, except: [:create]

    def create
        @review = Review.new(params.require(:review).permit(:rating, :body))
        @review.tutor = @user
        @review.student = current_user
        if @review.save
            Notification.create({body: "You have a new review!", user: @user})
            flash[:Notice] = "Review saved"
            redirect_to user_path(@user)
        else
            flash[:Error] = @review.errors.full_messages.to_sentence
            @reviews = @user.reviews_for.order(created_at: :desc)
            @lessons = @user.lessons.order(time_of_lesson: :asc)
            @review = Review.new
            redirect_to user_path(@user), status: 303
        end
    end

    def edit
    end

    def update
        if !current_user.is_tutor
            if @review.update(params.require(:review).permit(:rating, :body))
                redirect_to dashboard_admin_index_path
                flash[:Notice] = "Review updated"
            else
                flash[:Error] = @review.errors.full_messages.to_sentence
                @review = @user.reviews_for.order(created_at: :desc)
                @lessons = @user.lessons.order(time_of_lesson: :asc)
                @review = Review.new
                redirect_to dashboard_admin_index_path, status: 303
            end
        elsif current_user == @user
            if @review.update({published: true})
                Notification.create({body: "Your review was published!", user: @review.student})
                flash[:Notice] = "Review published"
                redirect_to dashboard_admin_index_path
            else
                flash[:Error] = @review.errors.full_messages.to_sentence
                @review = @user.reviews_for.order(created_at: :desc)
                @lessons = @user.lessons.order(time_of_lesson: :asc)
                @review = Review.new
                redirect_to dashboard_admin_index_path, status: 303
            end
        end
    end

    def destroy
        if @review.destroy
            redirect_to dashboard_admin_index_path
            if current_user == @review.student
                Notification.create({body: "A student has deleted their review of you.", user: @review.tutor})
                flash[:Notice] = "Review deleted"
            else
                Notification.create({body: "Your review was denied.", user: @review.student})
                flash[:Notice] = "Review denied"
            end
        else
            flash[:Error] = @review.errors.full_messages.to_sentence
            redirect_to dashboard_admin_index_path, status: 303
        end
    end

    private

    def find_user
        @user = User.find(params[:user_id])
    end

    def find_review
        @review = Review.find(params[:id])
    end
end
