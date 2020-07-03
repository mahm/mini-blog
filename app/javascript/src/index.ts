import Rails from '@rails/ujs'
import registerCustomElement from '@sonicgarden/vue-custom-element-rails/dist/slim'
import Vue from 'vue'
import VueApollo from 'vue-apollo'

import TopicForm from 'src/containers/TopicForm.vue'
import TopicsContainer from 'src/containers/TopicsContainer.vue'

export default function() {
  Rails.start()

  Vue.use(VueApollo)
  registerCustomElement('topic-form', TopicForm)
  registerCustomElement('topics-container', TopicsContainer)
}
