# Be sure to restart your server when you modify this file.

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# PortalAppProject::Application.config.session_store :active_record_store

module ActiveRecord
  class SessionStore < ActionDispatch::Session::AbstractStore

    module ClassMethods # :nodoc:
      def marshal(data)
        if data.has_key? 'flash'
          data['flash'].sweep
        end

        ActiveSupport::Base64.encode64( ActiveSupport::JSON.encode(data) ) if data
      end

      def unmarshal(data)
        unmarshalled = ActiveSupport::JSON.decode( ActiveSupport::Base64.decode64(data) ) if data
        flash_hash = ActionDispatch::Flash::FlashHash.new()

        if unmarshalled.has_key? 'flash'
          unmarshalled['flash'].each do |item, key|
            flash_hash[item] = key
          end   
        end
       
        unmarshalled['flash'] = flash_hash
        unmarshalled
      end

      def drop_table!
        connection_pool.clear_table_cache!(table_name)
        connection.drop_table table_name
      end

      def create_table!
        connection_pool.clear_table_cache!(table_name)
        connection.create_table(table_name) do |t|
          t.string session_id_column, :limit => 255
          t.text data_column_name
        end
        connection.add_index table_name, session_id_column, :unique => true
      end

    end
  end
end

NucatsAssist::Application.config.session_store :active_record_store