export const validation = {
    methods: {
        $clearErrors() {
            this.errors = {}
        },
        $setErrors(errors) {
            this.errors = errors
        },
        $hasError(field) {
            return this.errors && this.errors[field] && this.errors[field].length > 0
        },
        $errorClass(field) {
            return this.$hasError(field) ? 'has-danger' : ''
        },
        $errorMsg(field) {
            return this.$hasError(field) ? this.errors[field][0] : ''
        },
        $validate(rule, value) {
            if (rule.required && !value) {
                this.$setErrors({ [rule.field || 'field']: [rule.message || 'Campo requerido'] })
                return false
            }
            if (rule.min && value && value.length < rule.min) {
                this.$setErrors({ [rule.field || 'field']: [rule.message || `Mínimo ${rule.min} caracteres`] })
                return false
            }
            if (rule.pattern && value && !rule.pattern.test(value)) {
                this.$setErrors({ [rule.field || 'field']: [rule.message || 'Formato inválido'] })
                return false
            }
            return true
        },
        $validateAll(rules, data) {
            this.$clearErrors()
            const errors = {}
            for (const field in rules) {
                const value = data[field]
                for (const rule of rules[field]) {
                    if (rule.required && !value) {
                        errors[field] = [rule.message || 'Campo requerido']
                        break
                    }
                    if (rule.min && value && value.length < rule.min) {
                        errors[field] = [rule.message || `Mínimo ${rule.min} caracteres`]
                        break
                    }
                    if (rule.pattern && value && !rule.pattern.test(value)) {
                        errors[field] = [rule.message || 'Formato inválido']
                        break
                    }
                }
            }
            this.errors = errors
            return Object.keys(errors).length === 0
        }
    }
}
