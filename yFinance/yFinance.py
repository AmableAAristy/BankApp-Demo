from flask import Flask, request, jsonify
import yfinance as yf


app = Flask(__name__)

@app.route('/open', methods=['POST'])
def get_open_info():
    data = request.get_json()
    print(data)
    ticker_symbol = data.get('ticker', '')
    lengthOfRequest = data.get('length', '')
    #1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max
    #https://github.com/ranaroussi/yfinance/wiki/Ticker#history

    if not ticker_symbol:
        return jsonify({'error': 'Ticker symbol is required'}), 400

    ticker = yf.Ticker(ticker_symbol)

    hist = ticker.history(period=lengthOfRequest)



    open_prices = hist['Open'].tolist()


    prices_dict = {
        "open_prices": open_prices
    }
    

    return jsonify(prices_dict)

@app.route('/close', methods=['POST'])
def get_close_info():
    data = request.get_json()
    print(data)
    ticker_symbol = data.get('ticker', '')
    lengthOfRequest = data.get('length', '')
    #1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max
    #https://github.com/ranaroussi/yfinance/wiki/Ticker#history

    if not ticker_symbol:
        return jsonify({'error': 'Ticker symbol is required'}), 400

    ticker = yf.Ticker(ticker_symbol)

    hist = ticker.history(period=lengthOfRequest)



    close_prices = hist['Close'].tolist()
    

    prices_dict = {

        "close_prices": close_prices
    }
    

    return jsonify(prices_dict)

@app.route('/both', methods=['POST'])
def get_both_info():
    data = request.get_json()
    print(data)
    ticker_symbol = data.get('ticker', '')
    lengthOfRequest = data.get('length', '')
    #1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max
    #https://github.com/ranaroussi/yfinance/wiki/Ticker#history

    if not ticker_symbol:
        return jsonify({'error': 'Ticker symbol is required'}), 400

    ticker = yf.Ticker(ticker_symbol)

    hist = ticker.history(period=lengthOfRequest)

    hist.reset_index(inplace=True)

    
    date = hist['Date'].dt.strftime('%Y-%m-%d').tolist()
    open_prices = hist['Open'].tolist()
    close_prices = hist['Close'].tolist()
    

    prices_dict = {
        "date" : date,
        "open_prices": open_prices,
        "close_prices": close_prices
    }
    

    return jsonify(prices_dict)


if __name__ == '__main__':


    host = '0.0.0.0'
    port = 5000
    print(f"Flask is running on http://{host}:{port}")
    app.run(debug=True, host=host, port=port)