
class ReportsController < ApplicationController
	def index
	    @posts = Post.all

	    respond_to do |format|
	        …
	        format.xlsx {
	            send_data Post.to_xlsx.to_stream.read, :filename => 'posts.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
	        }
	    end
    end

end