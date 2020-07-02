import Rails from '@rails/ujs'
import registerCustomElement from '@sonicgarden/vue-custom-element-rails/dist/slim'

import TopicsContainer from 'src/containers/TopicsContainer.vue'

export default function() {
  Rails.start()

  registerCustomElement('topics-container', TopicsContainer)
}
