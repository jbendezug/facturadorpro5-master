function confirmDialog({ message, title, type = 'warning', confirmText, cancelText, icon }) {
    return this.$confirm(message, title, {
        confirmButtonText: confirmText || 'Confirmar',
        cancelButtonText: cancelText || 'Cancelar',
        type,
        icon,
        dangerouslyUseHTMLString: true,
        customClass: 'confirm-dialog-detailed'
    })
}

function handleError(error, defaultMsg) {
    if (error.response?.status === 500) {
        this.$notifyError?.(defaultMsg) || this.$message.error(defaultMsg)
    } else if (error.response?.data?.message) {
        this.$notifyError?.(error.response.data.message) || this.$message.error(error.response.data.message)
    }
}

function handleSuccess(res, successMsg) {
    if (res.data?.success) {
        this.$notifySuccess?.(res.data.message || successMsg) || this.$message.success(res.data.message || successMsg)
        return true
    }
    this.$notifyError?.(res.data?.message || 'Error') || this.$message.error(res.data?.message || 'Error')
    return false
}

export const deletable = {
    methods: {
        destroy(url, options = {}) {
            return new Promise((resolve) => {
                confirmDialog.call(this, {
                    message: options.message || '¿Desea eliminar el registro?<br><small class="text-muted">Esta acción no se puede deshacer</small>',
                    title: options.title || 'Eliminar',
                    confirmText: options.confirmText || 'Eliminar',
                    type: 'error',
                    icon: 'el-icon-delete'
                }).then(() => {
                    this.$http.delete(url)
                        .then(res => {
                            if(handleSuccess.call(this, res, 'Eliminado correctamente')) resolve()
                            else resolve()
                        })
                        .catch(error => handleError.call(this, error, 'Error al intentar eliminar'))
                }).catch(() => {})
            })
        },
        anular(url, options = {}) {
            return new Promise((resolve) => {
                confirmDialog.call(this, {
                    message: options.message || '¿Desea anular el registro?<br><small class="text-muted">Esta acción podría afectar documentos relacionados</small>',
                    title: options.title || 'Anular',
                    confirmText: options.confirmText || 'Anular',
                    type: 'warning',
                    icon: 'el-icon-warning'
                }).then(() => {
                    this.$http.get(url)
                        .then(res => {
                            if(handleSuccess.call(this, res, 'Anulado correctamente')) resolve()
                            else {
                                this.$notifyError?.(res.data?.message || 'Error al anular')
                                resolve()
                            }
                        })
                        .catch(error => handleError.call(this, error, 'Error al intentar anular'))
                }).catch(() => {})
            })
        },
        delete(url, options = {}) {
            return new Promise((resolve) => {
                confirmDialog.call(this, {
                    message: options.message || '¿Desea eliminar permanentemente el registro?<br><small class="text-danger">No se podrá recuperar</small>',
                    title: options.title || 'Eliminar permanentemente',
                    confirmText: options.confirmText || 'Eliminar',
                    type: 'error',
                    icon: 'el-icon-delete-solid'
                }).then(() => {
                    this.$http.get(url)
                        .then(res => {
                            if(handleSuccess.call(this, res, 'Eliminado permanentemente')) resolve()
                        })
                        .catch(error => handleError.call(this, error, 'Error al eliminar'))
                }).catch(() => {})
            })
        },
        disable(url, options = {}) {
            return new Promise((resolve) => {
                confirmDialog.call(this, {
                    message: options.message || '¿Desea inhabilitar el registro?<br><small class="text-muted">El registro no estará disponible temporalmente</small>',
                    title: options.title || 'Inhabilitar',
                    confirmText: options.confirmText || 'Inhabilitar',
                    type: 'warning'
                }).then(() => {
                    this.$http.get(url)
                        .then(res => {
                            handleSuccess.call(this, res, 'Inhabilitado correctamente')
                            resolve()
                        })
                        .catch(error => handleError.call(this, error, 'Error al inhabilitar'))
                }).catch(() => {})
            })
        },
        enable(url, options = {}) {
            return new Promise((resolve) => {
                confirmDialog.call(this, {
                    message: options.message || '¿Desea habilitar el registro?',
                    title: options.title || 'Habilitar',
                    confirmText: options.confirmText || 'Habilitar',
                    type: 'success',
                    icon: 'el-icon-success'
                }).then(() => {
                    this.$http.get(url)
                        .then(res => {
                            handleSuccess.call(this, res, 'Habilitado correctamente')
                            resolve()
                        })
                        .catch(error => handleError.call(this, error, 'Error al habilitar'))
                }).catch(() => {})
            })
        },
        voided(url, options = {}) {
            return new Promise((resolve) => {
                confirmDialog.call(this, {
                    message: options.message || '¿Desea anular el registro?<br><small class="text-muted">Se generará un comprobante de anulación</small>',
                    title: options.title || 'Anular',
                    confirmText: options.confirmText || 'Anular',
                    type: 'warning',
                    icon: 'el-icon-document-delete'
                }).then(() => {
                    this.$http.get(url)
                        .then(res => {
                            if(handleSuccess.call(this, res, 'Anulado correctamente')) resolve()
                        })
                        .catch(error => handleError.call(this, error, 'Error al anular'))
                }).catch(() => {})
            })
        },
        updateStateType(url, options = {}) {
            return new Promise((resolve) => {
                confirmDialog.call(this, {
                    message: options.message || '¿Desea modificar el estado del registro?',
                    title: options.title || 'Modificar estado',
                    confirmText: options.confirmText || 'Modificar',
                    type: 'info',
                    icon: 'el-icon-edit'
                }).then(() => {
                    this.$http.get(url)
                        .then(res => {
                            if(handleSuccess.call(this, res, 'Estado modificado')) resolve()
                        })
                        .catch(error => handleError.call(this, error, 'Error al modificar'))
                }).catch(() => {
                    this.$eventHub.$emit('reloadData')
                })
            })
        },
    }
}
