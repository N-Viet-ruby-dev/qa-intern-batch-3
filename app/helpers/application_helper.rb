module ApplicationHelper
	def count_index_list key
		key + 1
	end

	def full_title page_title = ""
		base_title = t ".base_title"
		if page_title.blank?
			base_title
		else
			page_title + " | " + base_title
		end
	end
end
