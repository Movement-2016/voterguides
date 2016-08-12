class UploadTarget < Struct.new(:folder_name)
  cattr_accessor :bucket

  def post
    @post ||= UploadTarget.bucket.presigned_post(
      key: "#{folder_name}/#{SecureRandom.uuid}/${filename}",
      success_action_status: '201',
      acl: 'public-read')
  end

  def data
    return "data-bucket=\"Bucket not defined\"" unless UploadTarget.bucket
    [
      "data-form-data=\"#{post.fields.to_json}\"",
      "data-url=\"#{post.url}\"",
      "data-host=\"#{URI.parse(post.url).host}\""
    ].join(" ")
  end
end
