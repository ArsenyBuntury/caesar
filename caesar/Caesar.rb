class Caesar
    attr_reader :key, :content

    def initialize(key)
        file = File.new("sample_text.txt", "r:UTF-8")
        content = file.read
        @content = content.downcase
        @key = key
    end

    def shift(byte, init_byte, limit_byte)
        new_byte = byte + key
        return init_byte - (limit_byte - new_byte) - 1 if new_byte > limit_byte
        new_byte
        end
    
    def encrypt
        content.bytes.map do |byte|
            case byte
            when 65..90 then shift(byte, 65, 90)
            when 97..122 then shift(byte, 97, 122)
            else byte 
            end
        end.pack('c*')
    end
    
    def unshift(byte, init_byte, limit_byte)
        new_byte = byte - key
        return limit_byte - (init_byte - new_byte) + 1 if new_byte > limit_byte
        new_byte
    end
    
    def unencrypt
        content.bytes.map do |byte|
            case byte
            when 65..90 then unshift(byte, 65, 90)
            when 97..122 then unshift(byte, 97, 122)
            else byte 
            end
        end.pack('c*')
    end 

    def self.encrypt(content, key)
        new(content, key).encrypt
    end

    def self.unencrypt(content,key)
        new(content, key).unencrypt
    end

    c1 = Caesar.new(3).encrypt
    puts c1
end

