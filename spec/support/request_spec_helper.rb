module RequestSpecHelper
    def json_body
        @json_body ||= JSON.parse(response.body, symbolize_names: true) # ||= quer dizer que vai ver se possui valaor senão tiver ele seta o JSON.parse...
    end
    
end