import { render } from '@testing-library/react'
import App from './App'

test('renders heading', () => {
  const { getByText } = render(<App />)
  expect(getByText('AI Agent Frontend')).toBeTruthy()
})