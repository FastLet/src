# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



  $(document).on 'change', '#states_select', (evt) ->
    $.ajax 'posts/update_cities',
      type: 'GET'
      dataType: 'script'
      data: {
        state_id: $("#states_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!");

  $(document).on 'change','#cities_select',(evt) ->
    $.ajax 'posts/update_areas',
      type: 'GET'
      dataType: 'script'
      data: {
        city_id: $("#cities_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic city select OK!")



