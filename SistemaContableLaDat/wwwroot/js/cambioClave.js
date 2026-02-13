function validarClave() {
    const clave = document.getElementById("Input_NuevaClave").value;
    const confirmacion = document.getElementById("Input_ConfirmarClave").value;

    if (!clave || !confirmacion) {
        alert("Todos los campos son requeridos.");
        return false;
    }

    if (clave !== confirmacion) {
        alert("Las contraseñas no coinciden.");
        return false;
    }

    if (!/^[A-Za-z]/.test(clave)) {
        alert("La contraseña debe iniciar con una letra.");
        return false;
    }
    if (!/[A-Za-z]/.test(clave) || 
        !/[0-9]/.test(clave) || 
        !/[+\-\*\$\.]/.test(clave)) {
        alert("La contraseña debe contener letras, números y símbolos (+-*$.).");
        return false;
    }

    return true;
}

function togglePassword(inputId) {
    const input = document.getElementById(inputId);
    const icon = document.getElementById("icon_" + inputId);

    if (input.type === "password") {
        input.type = "text";
        icon.classList.remove("bi-eye");
        icon.classList.add("bi-eye-slash");
    } else {
        input.type = "password";
        icon.classList.remove("bi-eye-slash");
        icon.classList.add("bi-eye");
    }
}

function autogenerarClave() {
    const longitud = 10;
    const letras = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const numeros = "0123456789";
    const simbolos = "+-*$.";

   
    let clave = letras[Math.floor(Math.random() * letras.length)]; //Empieza con letra

    const todos = letras + numeros + simbolos;

  
    for (let i = 1; i < longitud; i++) {
        clave += todos[Math.floor(Math.random() * todos.length)];  //Resto de la clave
    }

    
    if (!/[+\-\*\$\.]/.test(clave)) {
        const posicion = Math.floor(Math.random() * (longitud - 1)) + 1;
        clave = clave.substring(0, posicion) + simbolos[Math.floor(Math.random() * simbolos.length)] + clave.substring(posicion + 1); //Garantiza que tenga al menos 1 símbolo
    }

   
    const inputNueva = document.querySelector("input[name='Input.NuevaClave']"); //Asigna a inputs
    const inputConfirm = document.querySelector("input[name='Input.ConfirmarClave']"); //Asigna a inputs

    inputNueva.value = clave;
    inputConfirm.value = clave;
}
