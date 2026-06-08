import { Notification, Message } from 'element-ui'

export function notifySuccess(message, title = 'Éxito') {
    Notification({
        title,
        message,
        type: 'success',
        position: 'bottom-right',
        duration: 3000
    })
}

export function notifyError(message, title = 'Error') {
    Notification({
        title,
        message,
        type: 'error',
        position: 'bottom-right',
        duration: 5000
    })
}

export function notifyWarning(message, title = 'Advertencia') {
    Notification({
        title,
        message,
        type: 'warning',
        position: 'bottom-right',
        duration: 4000
    })
}

export function notifyInfo(message, title = 'Información') {
    Notification({
        title,
        message,
        type: 'info',
        position: 'bottom-right',
        duration: 3000
    })
}

export function toastSuccess(message) {
    Message({
        message,
        type: 'success',
        duration: 2000
    })
}

export function toastError(message) {
    Message({
        message,
        type: 'error',
        duration: 3000
    })
}
