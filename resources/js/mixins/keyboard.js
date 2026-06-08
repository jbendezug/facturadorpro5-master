export const keyboard = {
    mounted() {
        document.addEventListener('keydown', this._handleGlobalKeydown)
    },
    beforeDestroy() {
        document.removeEventListener('keydown', this._handleGlobalKeydown)
    },
    methods: {
        _handleGlobalKeydown(e) {
            if (e.key === 'Escape') {
                this._handleEscape()
            }
            if (e.key === 'F8') {
                e.preventDefault()
                this._handleF8()
            }
        },
        _handleEscape() {
            const dialog = this.$el?.querySelector('.el-dialog__wrapper')
            if (dialog && dialog.style.display !== 'none') {
                const closeBtn = dialog.querySelector('.el-dialog__headerbtn')
                closeBtn?.click()
            }
            if (typeof this.close === 'function') {
                this.close()
            }
        },
        _handleF8() {
            const submitBtn = this.$el?.querySelector('[type="submit"], .btn-save, .el-button--primary')
            if (submitBtn && !submitBtn.disabled) {
                submitBtn.click()
            }
        }
    }
}
