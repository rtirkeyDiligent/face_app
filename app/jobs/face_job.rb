class FaceJob < ApplicationJob
  queue_as :default

  def perform(upload_id)
    upload = Upload.find(upload_id)
    return unless upload.image.attached?

    # Call Python script for face detection
    result = `python3 lib/scripts/face_detection.py "#{upload.image.download}"`

    # Update metadata with result
    upload.image.metadata[:processed] = true
    upload.image.metadata[:face_detected] = result.include?('True')
    upload.image.save!
  end
end
