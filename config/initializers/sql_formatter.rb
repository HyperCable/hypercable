# frozen_string_literal: true

require "digest"

class SqlFormatter
  TMP_PATH = Rails.root.join("tmp")

  attr_reader :relation
  def initialize(relation)
    @relation = relation
  end

  def call
    sql = relation.to_sql
    path = File.join(TMP_PATH, Digest::MD5.hexdigest(sql)) + ".sql"
    File.open(path, "w+") { |file| file.write sql }
    `pg_format #{path}`
  end
end
