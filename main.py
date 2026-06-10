import os
import requests

def send_telegram_message(message):
    # Fetch credentials securely from environment variables
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    chat_id = os.getenv('TELEGRAM_CHAT_ID')
    
    if not bot_token or not chat_id:
        print("Error: Missing Telegram credentials in environment variables.")
        return
        
    url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
    payload = {
        "chat_id": chat_id,
        "text": message,
        "parse_mode": "Markdown"
    }
    
    try:
        response = requests.post(url, json=payload)
        if response.status_code == 200:
            print("Message sent successfully!")
        else:
            print(f"Failed to send message. Status code: {response.status_code}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    # The message that will be broadcasted automatically
    alert_text = (
        "🚀 *ZERO2DEV Daily Tracker Active*\n\n"
        "Your automated backend script executed successfully via GitHub Actions."
    )
    send_telegram_message(alert_text)
