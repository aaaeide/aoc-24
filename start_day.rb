# frozen_string_literal: true

require 'net/http'
require 'fileutils'
require 'dotenv'

def read_args
  unless ARGV.length == 1
    puts "Usage: ruby #{__FILE__} [day]"
    exit
  end

  ARGV[0]
end

def load_token
  Dotenv.load

  if ENV['TOKEN'].nil?
    puts 'Error: TOKEN is not set in .env'
    exit
  end

  ENV['TOKEN']
end

def make_request(url, token)
  uri = URI.parse(url)

  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
    req = Net::HTTP::Get.new uri
    req['Cookie'] = token
    http.request req
  end
end

def filename(dir)
  "#{dir}/data.txt"
end

def save_to_file(dir, data)
  FileUtils.mkdir_p(dir)

  File.open(filename(dir), 'w') do |f|
    f.write(data)
  end
end

year = 2024
day = read_args
token = load_token
url = "https://adventofcode.com/#{year}/day/#{day}/input"
dir = "./data/#{year}/#{day.to_s.rjust(2, '0')}/"

res = make_request(url, token)
unless res&.code.to_i == 200
  puts "Failed to fetch file. HTTP Status: #{res&.code}"
  exit
end

save_to_file(dir, res&.body)

puts "Input data saved to #{filename(dir)}"

FileUtils.mkdir("days/#{year}")
File.open("days/#{year}/day#{day.to_s.rjust(2, '0')}.rb", "w") do |f|
  f.write("# frozen_string_literal: true\n")
end
