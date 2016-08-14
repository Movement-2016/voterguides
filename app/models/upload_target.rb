class UploadTarget < Struct.new(:folder_name)

  def self.bucket
    if defined?(S3_BUCKET)
      @bucket ||= S3_BUCKET
    end
  end

  def post
    @post ||= UploadTarget.bucket.presigned_post(
      key: "#{folder_name}/#{SecureRandom.uuid}/${filename}",
      success_action_status: '201',
      acl: 'public-read')
  end

  def data
    return { bucket: "Bucket not defined" } unless UploadTarget.bucket
    {
      "form-data"=> post.fields,
      :url =>  post.url,
      :host =>  URI.parse(post.url).host
    }
  end
end
