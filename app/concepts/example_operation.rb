# # result = Publications::Post::Create.call(post_params)     # Все переданные аргументы будут доступны в операции как options["params"]
# # result["result.contract.default"].errors.messages         # Доступ к ошибкам

# module Publications::Post
#   class Create < Trailblazer::Operation
#     self => options hash
#
#     success :start                                # success не обрушит flow и будет считать, что вернулся true, даже если в реале был false
#     step    :condition_check                      # Если даст false, то перескакиваем сразу на failure, а если true, до идем дальше по всем step и success
#     failure :error_handle                         # будет выполнен только в том случае, если где-то в цепочке на step-методах будет false\nil

#     step Model( BlogPost, :new )                  # Создаст новую модель и запишет ее в options['model']. Для более сложной логики поиска или создания модели пиши отдельный метод
#     step Contract::Build( constant: BlogPost::Contract::Create ) # Это вместо model.update_attributes(params[:blog_post]). После этого шага будет доступно options["contract.default"] и там будет инстанс контракта
#     step Contract::Validate( key: :blog_post )    # На нашем options["contract.default"] будет валидироваться options["params"][:blog_post]. Без :key будут провалидированы все options['params']
#     # Кстати, теперь нет нужды в strong params, так как вместо них мы теперь строго прописываем ключи в white-list: типа "property :title; property :body"
#     step Contract::Persist()                      # Накладываем аттрибуты, прошедшие валидацию в модель и потом сохраняем ее. Псевдокод: options["contract.default"].save

#     # def example(options, *) OR  (options, params:, smth_var_from_options_for_quick_access:, **)
#     #  options       ->     <Skill {} {"params"=>....} {"pipetree"=>...}>
#     # end

#     def start(options, params:, **)
#       puts 'Started!'
#       # success
#     end

#     def condition_check(options, params:, **)
#       if false
#         true
#       else
#         options['errors'] = 'Condition was in else part'   # Записывай в options всю нужную инфу
#         false
#       end

#       # step! Value matters!
#     end

#     def error_handle(options, params:, **)
#       puts 'Error happened!'
#       puts options['errors']
#     end
#   end
# end