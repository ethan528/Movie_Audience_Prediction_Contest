// npm install axios
const axios = require('axios');

const token = 'ya29.c.c0ASRK0GZN8460fBIaW8eYVoVF5AMcBPOeqPwr4kAXnbA_J3NMkPk-nWPulRDe2ZJZcvEs4ZNK8qh_rHOUFvDhLUZfkMDHS-S7Zrtli19UZL77X6fmGTCyxAMq_j-E-_dLXy_-jicjWfdXZCbMPoiPb3wff8k5gh7GorwMPAsej9ZqP0xYjlE-ORCInFyJjT4bc3snIrzg9RCePzS_CUaVwZPKpcWrti8ECSZsRLunXdp26yofUd4ypau3kNsXmmRRbTvlWPBsiuYvxWu6In3Ll0sY_4hQHf8C9j44LZL0SmcyR2eM66NE-PDzgbHNIusXVi2gFTlZDOwfzzfI6vfudv9ShbunZFISEMTGQHwUUYVKCeNNEcRfvd0T384DaxnIjtYwjXYwlSl5OrIFQMyeUvmdbiV0Wx-nOk52tOqmRrlsau33qofvOz0c4p-tiUqB89vvkU5Q0sF5n1nvtrc-ulBwMv7ZByfRcBswi6c-oYasubQ8hMJjmk3tVfBBggvavaOsmkqczV1ak_Zku21tSwB21R6ulQJpdxhYnvIlWXBwZVOdeQ7Qz-cqO3lxtuca9dFIr3cubjIF-b3Y4MFswSowhbk7Jwpmxg2u09pXtesujm6c6W3I25uW07yOptqshBWUnaMsifgufyguVBSt0fd0gO2ubM4jSbqkvib0FnqOSqgxFWvwIs7uBBjsrbofaVqsSVcwbQwdb6QS9s1ebI59gf_xbvu318RRvzgp4qs-lxaecRr8b_QuJp_tvXUWXi19l5x3s1_WQxM39eZrWy3Ruor594ipf1Bs66XaxBoaUj4v821g1dBIX-qwtrcf8cqQpuqdu89z_WstXjJ6Flcvo10zilgyIm9xfi1UIlMFWroOWMa6v6r4bSmtZehgw4X--F1bqzot2exlZMw47XlXRd0MvQjaOnx7oslsma8n_RfYy2p81jSquVB6p29QWi4QwJ8wtZ7efV0ZigYbSSM6Z3bJsat0gtVcdwj2pySyar8Q5Ipaal6'; // Replace with your generated token

const url = 'https://fcm.googleapis.com/v1/projects/fcm-test-9609c/messages:send';

const messagePayload = {
  message: {
    topic: "all_devices",
    notification: {
      title: "Broadcast Notification",
      body: "This message is sent to all devices!"
    },
    data: {
      type: "chat" // Used for navigation
    },
    android: {
      priority: "high",
      notification: {
        channel_id: "high_importance_channel"
      }
    }
  }
};

const headers = {
  'Authorization': `Bearer ${token}`,
  'Content-Type': 'application/json'
};

axios.post(url, messagePayload, { headers })
  .then(response => {
    console.log('Message sent successfully:', response.data);
  })
  .catch(error => {
    console.error('Error sending message:', error.response ? error.response.data : error.message);
  });