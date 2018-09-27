// ==UserScript==
// @name         Jobcan shift tsv importer
// @description  Jobcan shift tsv importer
// @namespace    https://github.com/NaoyaIchikawa
// @version      1.0
// @author       Naoya Ichikawa
// @match       https://ssl.jobcan.jp/employee/shift-pattern-request*
// @grant        none
// ==/UserScript==

(function() {
  'use strict';
  // Your code here...


  //  sample imput

  function input_schedule(){
    var  t_area=document.getElementsByName("shift-bulk-import")[0]
    var rows = t_area.value.split("\n")

    rows.forEach(function(row,index,ar){
      var col = row.split("\t")
      var date        = Number(col[0])

      var start       = col[1]
      var start_h     = Number(start.split(":")[0])
      var start_m     = Number(start.split(":")[1])

      var end         = col[2]
      var end_h       = Number(end.split(":")[0])
      var end_m       = Number(end.split(":")[1])


      var rest_start = col[3]
      var rest_start_h     = Number(rest_start.split(":")[0])
      var rest_start_m     = Number(rest_start.split(":")[1])

      var rest_end = col[4]
      var rest_end_h     = Number(rest_end.split(":")[0])
      var rest_end_m     = Number(rest_end.split(":")[1])


      var row_n       = date -1


      //時刻指定ボタンを押す
      document.getElementsByName("shift["+ row_n+ "][shift_pattern_id]")[0].nextElementSibling.value="custom"
      ShiftPatternRequest.changeShift(row_n);

      //開始時間
      document.getElementsByName("shift["+ row_n+ "][start][h]")[0].value= Number(start_h)-5
      document.getElementsByName("shift["+ row_n+ "][start][m]")[0].value= start_m

      //終了時間
      document.getElementsByName("shift["+ row_n+ "][end][h]")[0].value= Number(end_h)-5
      document.getElementsByName("shift["+ row_n+ "][end][m]")[0].value= end_m


       //休憩開始時間
      document.getElementsByName("shift["+ row_n+ "][rest_start][h]")[0].value= Number(rest_start_h)-5
      document.getElementsByName("shift["+ row_n+ "][rest_start][m]")[0].value= rest_start_m

      //休憩終了時間
      document.getElementsByName("shift["+ row_n+ "][rest_end][h]")[0].value= Number(rest_end_h)-5
      document.getElementsByName("shift["+ row_n+ "][rest_end][m]")[0].value= rest_end_m
    });


  };

  var import_component = document.createElement ('div');
  import_component.style = "position: fixed; top: 0; width:30%; z-index: 10000;"
  import_component.innerHTML='\
    <textarea name="shift-bulk-import" rows="4" cols="40" ></textarea>\
    <button type="button" id="bulk_import_button">import 実行</button>'

  document.body.appendChild (import_component);

  var button=document.getElementById("bulk_import_button");
  button.addEventListener("click", input_schedule, false);

})();
