// validate input email instantly by using oninput function
var vEmailInput = document.getElementById("vEmail");
let resultEmail;
vEmailInput.oninput = function (e) {
	resultEmail = e.target.value;
	console.log(resultEmail);
	var emailAlert = document.querySelector(".emailAlert");
	emailAlert.classList.add("cHide");

	let email_RegExp = /[a-z0-9._%+-]+@[a-z0-9.-]{2,}$/;
	if (email_RegExp.test(resultEmail) == false) {
		emailAlert.classList.remove("cHide");
	}
};
// validate input phone number instantly by using oninput function

var vPhoneInput = document.getElementById("vPhone");
let resultPhone;
vPhoneInput.oninput = function (e) {
	resultPhone = e.target.value;
	console.log(resultPhone);
	var phoneAlert = document.querySelector(".phoneAlert");
	phoneAlert.classList.add("cHide");
	let phone_RegExp = /[0-9]{7,}/;
	if (phone_RegExp.test(resultPhone) == false) {
		phoneAlert.classList.remove("cHide");
	}
};

var FormContact = document.getElementById("FormContact");
FormContact.onsubmit = function (e) {
	e.preventDefault();

	var vName = document.getElementById("vName").value.trim();
	var vEmail = document.getElementById("vEmail").value.trim();
	var vPhone = document.getElementById("vPhone").value.trim();
	var vComment = document.getElementById("vComment").value.trim();

	let email_RegExp = /[a-z0-9._%+-]+@[a-z0-9.-]{2,}$/;
	if (email_RegExp.test(vEmail) == false) {
		vEmail.focus();
		return false;
	}
	let phone_RegExp = /[0-9]{7,}/;
	if (phone_RegExp.test(vPhone) == false) {
		vPhone.focus();
		return false;
	}
	document.querySelector(".alert_Name_Fillin").innerHTML = vName;
	document.querySelector(".alert_email_Fillin").innerHTML = vEmail;
	document.querySelector(".alert_phone_Fillin").innerHTML = vPhone;
   document.querySelector(".alert_comment_Fillin").innerHTML = vComment;
   var cAlert = document.querySelector('.cAlert');
   cAlert.classList.remove('cHide');
   cAlert.classList.add('cFadeIn');
};

var cAlert = document.querySelector('.cAlert');
cAlert.onclick = function () {
   cAlert.classList.add('cHide');
   cAlert.classList.remove('cFadeIn');
   document.querySelector(".alert_Name_Fillin").innerHTML = '';
	document.querySelector(".alert_email_Fillin").innerHTML = '';
	document.querySelector(".alert_phone_Fillin").innerHTML = '';
   document.querySelector(".alert_comment_Fillin").innerHTML = '';
   document.getElementById('vName').value = '';
   document.getElementById('vEmail').value = '';
   document.getElementById('vPhone').value = '';
   document.getElementById('vComment').value = '';

}