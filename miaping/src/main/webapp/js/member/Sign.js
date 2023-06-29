function chk_form() {
  if(document.getElementById("name").value==''){
    alert("성명을 입력해주십시오.");
    return false;
  }
  if(document.getElementById("pwd").value==''){
    alert("비밀번호를 입력해주십시오.");
    return false;
  }
  // if ( ! $('input[name=agreeBtm]:checked').val()) {
  //   alert('개인정보 활용에 동의해주십시오.');
  //   return false;
  // }
  document.getElementById('frm').submit();
  }