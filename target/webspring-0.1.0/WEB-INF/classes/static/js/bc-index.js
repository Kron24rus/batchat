isSignInButtonEnabled = false;

signInButtonID = 'loginButton';
userNameInputID = 'usernameInput';
passwordInputID = 'passwordInput';


function setEnabled( objectID ){
	document.getElementById( objectID ).className = document.getElementById( objectID ).className.replace('disabled', '');
}

function setDisabled( objectID ){
	document.getElementById( objectID ).className = document.getElementById( objectID ).className + ' disabled';
}

function checkInput(){
	isUserNameEmpty = document.getElementById( userNameInputID ).value == '';
	isUserPasswordEmpty = document.getElementById( passwordInputID ).value == '';
	isAnyFieldEmpty = isUserNameEmpty || isUserPasswordEmpty;

	if( isAnyFieldEmpty ){
		if( isSignInButtonEnabled ){
			setDisabled( signInButtonID );
			isSignInButtonEnabled = false;
		}
	}
	else{
		if( ! isSignInButtonEnabled ){
			setEnabled( signInButtonID );
			isSignInButtonEnabled = true;
		}
	}
}