function validarClave() {
    const clave = document.getElementById("Input_NuevaClave").value;
    const confirmacion = document.getElementById("Input_ConfirmarClave").value;
    const errorSpan = document.getElementById("errorConfirmacion");

    errorSpan.textContent = "";

    if (!clave || !confirmacion) {
        errorSpan.textContent = "Todos los campos son requeridos.";
        return false;
    }

    if (clave !== confirmacion) {
        errorSpan.textContent = "Las contraseñas no coinciden.";
        return false;
    }

    if (!/^[A-Za-z]/.test(clave)) {
        errorSpan.textContent = "La contraseña debe iniciar con una letra.";
        return false;
    }

    if (!/[A-Za-z]/.test(clave) ||
        !/[0-9]/.test(clave) ||
        !/[+\-\*\$\.]/.test(clave)) {
        errorSpan.textContent = "La contraseña debe contener letras, números y símbolos (+-*$.).";
        return false;
    }

    return true;
}

function togglePassword(inputId) {
    const input = document.getElementById(inputId);
    const icon = document.getElementById("icon_" + inputId);

    if (input.type === "password") {
        input.type = "text";
        icon.classList.remove("bi-eye-slash");
        icon.classList.add("bi-eye");
    } else {
        input.type = "password";
        icon.classList.remove("bi-eye");
        icon.classList.add("bi-eye-slash");
    }
}

function autogenerarClave() {
    const longitud = 10;
    const letras = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const numeros = "0123456789";
    const simbolos = "+-*$.";

    let clave = letras[Math.floor(Math.random() * letras.length)];
    const todos = letras + numeros + simbolos;

    for (let i = 1; i < longitud; i++) {
        clave += todos[Math.floor(Math.random() * todos.length)];
    }

    if (!/[+\-\*\$\.]/.test(clave)) {
        const posicion = Math.floor(Math.random() * (longitud - 1)) + 1;
        clave = clave.substring(0, posicion) +
            simbolos[Math.floor(Math.random() * simbolos.length)] +
            clave.substring(posicion + 1);
    }

    document.getElementById("Input_NuevaClave").value = clave;
    document.getElementById("Input_ConfirmarClave").value = clave;
}
