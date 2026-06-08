<template>
    <div id="styleSwitcher" class="style-switcher">
        <a id="styleSwitcherOpen" class="style-switcher-open" href="#" @click.prevent>
            <i class="fas fa-paint-brush"></i>
        </a>

        <div class="style-switcher-wrap" autocomplete="off">
            <h4>Configuraciones visuales</h4>

            <div class="pt-3">
                <h5>Modo de interfaz</h5>
                <a
                    href="#"
                    class="notification-icon"
                    :class="isDark ? 'text-white' : 'text-secondary'"
                    title="Cambiar modo"
                    style="text-decoration: none;"
                    @click.prevent="toggleMode"
                >
                    <i v-if="!isDark" class="fas fa-2x fa-moon"></i>
                    <i v-else class="fa-2x wi-sun"></i>
                </a>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            isDark: false,
            storageKey: 'system_theme'
        }
    },
    mounted() {
        const savedTheme = localStorage.getItem(this.storageKey)
        this.isDark = savedTheme === 'dark'
        this.applyMode()
    },
    methods: {
        applyMode() {
            const html = document.documentElement
            if (this.isDark) {
                html.classList.add('dark')
            } else {
                html.classList.remove('dark')
            }
        },
        toggleMode() {
            this.isDark = !this.isDark
            this.applyMode()
            localStorage.setItem(this.storageKey, this.isDark ? 'dark' : 'light')
        }
    }
}
</script>
