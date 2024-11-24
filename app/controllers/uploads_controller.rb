class UploadsController < ApplicationController
  def index
    uploads = Upload.all
    render json: uploads.map { |upload| upload_response(upload) }
  end

  def create
    upload = Upload.new(upload_params)

    if upload.save
      FaceJob.perform_later(upload.id) # Enqueue background job
      render json: upload_response(upload), status: :created
    else
      render json: { errors: upload.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:title, :image)
  end

  def upload_response(upload)
    {
      id: upload.id,
      title: upload.title,
      image_url: url_for(upload.image),
      processed: upload.image.metadata[:processed] || false
    }
  end
end
