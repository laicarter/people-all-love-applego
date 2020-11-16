class KamigoController < ApplicationController
	protect_from_forgery with: :null_session
	def eat 
		render plain:"吃土啦"
	end
	def request_headers 
		render plain: request.headers.to_h.reject{ |key, value|key.include? '.' }.map{ |key, value|"#{key}: #{value}"}.sort.join("\n")
	end
	def request_body
		render plain: request.body
	end
	def response_headers
		response.headers['Kamigo'] = ' Apple 小組' 
		render plain: response.headers.to_h.map{ |key, value|
		  "#{key}: #{value} " }.sort.join("\n")
	end
	def show_group_data
		response.headers['1.小組名稱'] = 'Apple 小組' 
		response.headers['2.小組成員'] = '謝幸蓉' + '.' + '廖慧娟' + '....'
		render plain: response.headers.to_h.map{ |key, value|
		  "#{key}: #{value} " }.sort.join("\n")
	end
	def show_response_body
		puts "===這是設定前的response.body:#{response.body}==="
		render plain: "虎哇花哈哈哈"
		puts "===這是設定後的response.body:#{response.body}==="
	end
	def webhook
		render plain: params
	end
	def sent_request
		#uri = URI('http://localhost:3000/kamigo/response_body')
		uri = URI('https://eip.sinon.com.tw')
		response = Net::HTTP.get(uri)
		#response = Net::HTTP.get(uri).force_encoding("UTF-8")
		#start_index = response.index("興") 
    	#end_index = response.index('司') - 1
		render plain: response # response[start_index..end_index] response
		#render plain: translate_to_korean('愛老虎') # '愛老虎')
	end
	def translate_to_korean(message)
		"#{message}油~油~"
	end
end
