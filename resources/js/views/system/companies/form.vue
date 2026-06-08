<template>
    <div class="card">
        <div class="card-header bg-info">
            <h3 class="my-0">Datos de la Empresa</h3>
        </div>
        <div class="card-body">
            <form autocomplete="off" @submit.prevent="submit">
                <div class="form-body">
                    <div class="row">
                        <div class="col-md-12 mt-2">
                            <h4 class="border-bottom">Entorno del sistema</h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group" :class="{'has-danger': errors.soap_send_id}">
                                <label class="control-label">SOAP Envio</label>
                                <el-select  v-model="form.soap_send_id" >
                                    <el-option v-for="(option, index) in soap_sends" :key="index" :value="option.value" :label="option.text"></el-option>
                                </el-select>
                                <small class="form-control-feedback" v-if="errors.soap_send_id" v-text="errors.soap_send_id[0]"></small>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group" :class="{'has-danger': errors.soap_type_id}">
                                <label class="control-label">SOAP Tipo</label>
                                <el-select  v-model="form.soap_type_id">
                                    <el-option v-for="option in soap_types" :key="option.id" :value="option.id" :label="option.description"></el-option>
                                </el-select>

                                <el-checkbox
                                       v-if="form.soap_send_id == '02' && form.soap_type_id == '01'"
                                       v-model="toggle"
                                       label="Ingresar Usuario">
                                </el-checkbox>
                                <small class="form-control-feedback" v-if="errors.soap_type_id" v-text="errors.soap_type_id[0]"></small>
                            </div>
                        </div>
                    </div>
                    <template v-if="form.soap_type_id == '02' || toggle == true ">
                        <div class="row" >
                            <div class="col-md-12 mt-2">
                                <h4 class="border-bottom">Usuario Secundario Sunat</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group" :class="{'has-danger': errors.soap_username}">
                                    <label class="control-label">SOAP Usuario <span class="text-danger">*</span></label>
                                    <el-input v-model="form.soap_username"></el-input>
                                    <div class="sub-title text-muted"><small>RUC + Usuario. Ejemplo: 01234567890ELUSUARIO</small></div>
                                    <small class="form-control-feedback" v-if="errors.soap_username" v-text="errors.soap_username[0]"></small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group" :class="{'has-danger': errors.soap_password}">
                                    <label class="control-label">SOAP Password <span class="text-danger">*</span></label>
                                    <el-input v-model="form.soap_password"></el-input>
                                    <small class="form-control-feedback" v-if="errors.soap_password" v-text="errors.soap_password[0]"></small>
                                </div>
                            </div>
                        </div>
                    </template>
                    <div class="row" v-if="form.soap_send_id == '02'">
                        <div class="col-md-12">
                            <div class="form-group" :class="{'has-danger': errors.soap_url}">
                                <label class="control-label">SOAP Url</label>
                                <el-input v-model="form.soap_url"></el-input>
                                <small class="form-control-feedback" v-if="errors.soap_url" v-text="errors.soap_url[0]"></small>
                            </div>
                        </div>
                    </div>

                    <!-- NUEVA SECCIÓN: Guía de Remisión Electrónica (GRE) -->
                    <template v-if="form.soap_type_id == '02'">
                        <div class="row">
                            <div class="col-md-12 mt-3">
                                <h4 class="border-bottom">
                                    Guía de Remisión Electrónica (GRE) - Nueva API REST
                                    <el-tooltip class="item"
                                                content="RS N° 000123-2022/SUNAT - Esquema CustomizationID 2.0 con OAuth 2.0"
                                                effect="dark"
                                                placement="top-start">
                                        <i class="fa fa-info-circle"></i>
                                    </el-tooltip>
                                </h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <el-checkbox v-model="form.use_gre">
                                        <strong>Habilitar nuevo esquema GRE (REST + OAuth 2.0)</strong>
                                    </el-checkbox>
                                    <div class="sub-title text-muted">
                                        <small>Al activar esta opción, las guías de remisión se enviarán mediante la nueva API REST de SUNAT. <strong>Requiere credenciales OAuth</strong> obtenidas en el portal SOL SUNAT.</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <template v-if="form.use_gre">
                            <div class="row">
                                <div class="col-md-6">
                                    <div :class="{'has-danger': errors.gre_client_id}" class="form-group">
                                        <label class="control-label">GRE Client ID <span class="text-danger">*</span></label>
                                        <el-input v-model="form.gre_client_id" placeholder="test-85e5b0ae-255c-4891-a595-..."></el-input>
                                        <div class="sub-title text-muted"><small>Client ID OAuth otorgado por SUNAT SOL para GRE</small></div>
                                        <small v-if="errors.gre_client_id" class="form-control-feedback" v-text="errors.gre_client_id[0]"></small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div :class="{'has-danger': errors.gre_client_secret}" class="form-group">
                                        <label class="control-label">GRE Client Secret <span class="text-danger">*</span></label>
                                        <el-input v-model="form.gre_client_secret" type="password" show-password placeholder="test_x7v0hLzJe2/S7vG..."></el-input>
                                        <div class="sub-title text-muted"><small>Client Secret OAuth otorgado por SUNAT SOL para GRE</small></div>
                                        <small v-if="errors.gre_client_secret" class="form-control-feedback" v-text="errors.gre_client_secret[0]"></small>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="alert alert-info">
                                        <i class="fa fa-lightbulb-o"></i>
                                        <strong>¿Cómo obtener estas credenciales?</strong>
                                        <ol class="mb-0 mt-2" style="padding-left: 20px;">
                                            <li>Ingresar a <strong>SUNAT Operaciones en Línea</strong> con Clave SOL</li>
                                            <li>Ir a <strong>Mis aplicaciones</strong> → <strong>Crear nueva aplicación</strong></li>
                                            <li>Seleccionar <strong>Guía de Remisión Electrónica (GRE)</strong></li>
                                            <li>SUNAT entregará el <strong>Client ID</strong> y <strong>Client Secret</strong></li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </template>
                    </template>

                </div>
                <div class="form-actions text-right pt-2">
                    <el-button type="primary" native-type="submit" :loading="loading_submit">Guardar</el-button>
                </div>
            </form>
        </div>
    </div>
</template>

<script>

    export default {
        data() {
            return {
                loading_submit: false,
                headers: headers_token,
                resource: 'companies',
                errors: {},
                form: {},
                soap_sends: [],
                soap_types: [],
                toggle: false, //Creando el objeto a retornar con v-model
                soap_sends: [ { value: '01', text: 'Sunat' }, { value: '02', text: 'Ose' }],
                soap_types: [{id: "01", description: "Demo"}, {id: "02", description: "Producción"}],
            }
        },
        async created() {
            await this.initForm()
            /*await this.$http.get(`/${this.resource}/tables`)
                .then(response => {
                    this.soap_sends = response.data.soap_sends
                    this.soap_types = response.data.soap_types
                })*/
            await this.$http.get(`/${this.resource}/record`)
                .then(response => {
                    if (response.data !== '') {
                        this.form = response.data.data
                    }
                })
        },
        methods: {
            initForm() {
                this.errors = {}
                this.form = {
                    id: null,
                    certificate: '',
                    soap_send_id: '01',
                    soap_type_id: '01',
                    soap_username: null,
                    soap_password: null,
                    soap_url: null,
                    use_gre: false,
                    gre_client_id: null,
                    gre_client_secret: null,
                }
            },
            submit() {
                this.loading_submit = true
                this.$http.post(`/${this.resource}`, this.form)
                    .then(response => {
                        if (response.data.success) {
                            this.$message.success(response.data.message)
                        } else {
                            this.$message.error(response.data.message)
                        }
                    })
                    .catch(error => {
                        if (error.response.status === 422) {
                            this.errors = error.response.data
                        } else {
                            console.log(error)
                        }
                    })
                    .then(() => {
                        this.loading_submit = false
                    })
            },

        }
    }
</script>
