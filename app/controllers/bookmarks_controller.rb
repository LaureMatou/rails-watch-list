class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end

# A user can add a new bookmark (movie/list pair) to an existing list
# Checkout simple_form docs about f.association to easily create a select dropdown for our list of movies.
# GET "lists/42/bookmarks/new"
# POST "lists/42/bookmarks"
# A user can delete a bookmark from a list. How can we make a delete link again?
# DELETE "bookmarks/25"
# Do we need a MoviesController?
