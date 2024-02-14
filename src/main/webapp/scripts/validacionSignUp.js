const username = document.getElementById("username");
const email = document.getElementById("email");
const password = document.getElementById("password");
const retypePassword = document.getElementById("retypePassword");
const nameForm = document.getElementById("name");
const surnames = document.getElementById("surnames");
const formulario = document.getElementById("form");

document.addEventListener('DOMContentLoaded', () => {

    const isRequired = value => value === '' ? false : true;

    const isEmailValid = (email) => {
        const re = /^(([^<>()\].,;:\s@"]+(\.[()\[\\.,;:\s@"]+)*)|(".+"))@(([0−9]1,3\.[0−9]1,3\.[0−9]1,3\.[0−9]1,3)|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    };
    
    const isPasswordSecure = (password) => {
        const re = new RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[*¿?!])([A-Za-z\d*¿?!]|[^ ]){8,12}$/);
        return re.test(password);
    };

    const showError = (input, message) => {
        // Obtener el elemento form-field
        const formField = input.parentElement;
        // Agregar la clase de error
        formField.classList.remove('success');
        formField.classList.add('error');
        // Mostrar el mensaje de error
        const error = formField.querySelector('small');
        error.textContent = message;
    };
    
    const showSuccess = (input) => {
        // Obtener el elemento form-field
        const formField = input.parentElement;
        // Eliminar la clase de error
        formField.classList.remove('error');
        formField.classList.add('success');
        // Ocultar el mensaje de error
        const error = formField.querySelector('small');
        error.textContent = '';
    };

    const checkUsername = () => {
        let valid = false;
        const usernameValue = username.value.trim();
        if (!isRequired(usernameValue)) {
          showError(username, 'El nombre de usuario no puede estar en blanco.');
        } else {
          showSuccess(username);
          valid = true;
        }
        return valid;
    };

    const checkEmail = () => {
        let valid = false;
        const emailValue = email.value.trim();
        if (!isRequired(emailValue)) {
            showError(email, 'El email no puede estar en blanco');
        }
        else if (!isEmailValid(emailValue)) {
            showError(email, 'El formato del email no es válido');
        }
        else {
            showSuccess(email);
            valid = true;
        }
        return valid;
    }
    
    const checkPassword = () => {
        let valid = false;
        const passwordValue = password.value.trim();
        if (!isRequired(passwordValue)) {
            showError(password, 'La contraseña no puede estar vacia');
        }
        else if (isPasswordSecure(passwordValue)) {
            showError(password, 'La contraseña introducida no es lo suficientemente segura');
        }
        else {
            showSuccess(password);
            valid = true;
        }
        return valid;
    }

    const checkRepeatPassword = () => {
        let valid = false;
        const retypePasswordValue = retypePassword.value.trim();
        const passwordValue = password.value.trim();
        if (!isRequired(retypePasswordValue)) {
            showError(retypePassword, 'El campo de repetir contraseña no puede estar vacio');
        }
        else if (!(retypePasswordValue == passwordValue)) {
            showError(retypePassword, 'La contraseña repetida no es igual a la anteriormente introducida')
        }
        else {
            showSuccess(retypePassword);
            valid = true;
        }
        return valid;
    }

    const checkName = () => {
        let valid = false;
        const nameValue = nameForm.value.trim();
        if (!isRequired(nameValue)) {
            showError(nameForm, 'El campo name no puede estar vacio');
        }
        else {
            showSuccess(nameForm);
            valid = true;
        }
        return valid;
    }

    const checkSurnames = () => {
        let valid = false;
        const surnamesValue = surnames.value.trim();
        if (!isRequired(surnamesValue)) {
            showError(surnames, 'El campo surnames no puede estar vacio');
        }
        else {
            showSuccess(surnames);
            valid = true;
        }
        return valid;
    }

    const debounce = (fn, delay = 500) => {
        let timeoutId;
        return (...args) => {
        // Cancelar el temporizador anterior si existe
        if (timeoutId) {
            clearTimeout(timeoutId);
        }
        // Configurar un nuevo temporizador
        timeoutId = setTimeout(() => {
            fn.apply(null, args)
        }, delay);
        };
    };

    formulario.addEventListener('input', debounce(function (e) {
        switch (e.target.id) {
          case 'username':
            checkUsername();
            break;
          case 'email':
            checkEmail();
            break;
          case 'password':
            checkPassword();
            break;
          case 'retypePassword':
            checkRepeatPassword();
            break;
          case 'name':
            checkName();
            break;
          case 'surnames':
            checkSurnames();
            break;
        }
    }));

})