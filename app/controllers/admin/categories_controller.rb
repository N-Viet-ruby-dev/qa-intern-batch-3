class Admin::CategoriesController < Admin::BaseController
	def new
		@category = Category.new
	end

	def create
		@category = Category.new category_params
		if @category.save
			flash[:success] = t ".success"
			redirect_to admin_categories_path
		else
			flash.now[:danger] = t ".danger"
			render :new
		end
	end

	private

	def category_params
		params.require(:category).permit :name, :description
	end
end