class CommentReflex < ApplicationReflex
  def submit_new
    @comment = Comment.new(comment_params)
    @comment.user_id = element.dataset[:current_user_id].to_i
    @comment.tutor_session_id = element.dataset[:current_tutor_session_id].to_i
    @comment.save
  end

  def edit
    @edit_mode = element.dataset[:comment_id].to_i
  end

  def update
    comment = Comment.find_by(id: element.dataset[:comment_id])
    comment.update(params.require(:comment).permit(:body))
    clear_edit_mode
  end

  def cancel_edit
    clear_edit_mode
  end

  def destroy
    comment = Comment.find_by(id: element.dataset[:comment_id])
    comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def clear_edit_mode
      @edit_mode = nil
    end
end
